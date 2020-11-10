# Use an official Ubuntu runtime as a base image
FROM ubuntu:focal

# Let the user tune the available Python versions
ARG SIMUNE_PYTHON_VERSIONS="3.8.5 3.7.9 3.6.12"

# Adjust system parameters
ENV DEBIAN_FRONTEND="noninteractive"

# Use Bash as default shell for more command-line flexibility
SHELL ["/bin/bash", "-c"]

# Install the required development packages
WORKDIR /root
COPY packages-system.txt ./
RUN apt-get update -y && \
    apt-get install apt-utils -y && \
    /bin/bash -c "xargs -a <(awk '/^\s*[^#]/' packages-system.txt) -r -- apt-get install -y" && \
    apt-get purge -y *-doc && \
    apt-get clean && \
    rm -rf /var/cache/apt && \
    rm -rf /var/lib/apt/lists/*

# Prepare the environment
RUN echo "C.UTF-8 UTF-8" >/etc/locale.gen && \
    echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen && \
    locale-gen && \
    update-locale LANG="C.UTF-8" && \
    echo "LANG=\"C.UTF-8\"" >/etc/default/locale && \
    echo "LC_ALL=\"C.UTF-8\"" >>/etc/default/locale

# Install the required development packages
WORKDIR /root
COPY packages-python.txt ./
RUN apt-get update -y && \
    /bin/bash -c "xargs -a <(awk '/^\s*[^#]/' packages-python.txt) -r -- apt-get install -y --no-install-recommends" && \
    apt-get purge -y *-doc && \
    apt-get clean && \
    rm -rf /var/cache/apt && \
    rm -rf /var/lib/apt/lists/*

# Make the hypermodern environment loadable
# Note: These files are required at this location in the following steps.
WORKDIR /root
COPY load-hypermodern-env.sh ./
COPY show-current-env.sh ./
RUN chmod u=rw,g=r,o=r ./load-hypermodern-env.sh && \
    chmod u=rwx,g=rx,o=rx ./show-current-env.sh
COPY hypermodern-constraints.txt ./
COPY hypermodern-requirements.txt ./
COPY install-hypermodern-env.sh ./
RUN /bin/bash ./install-hypermodern-env.sh ${SIMUNE_PYTHON_VERSIONS}

# Create a virtual environment for application development
COPY app-constraints.txt ./
COPY app-requirements.txt ./
COPY install-app-env.sh ./
RUN /bin/bash ./install-app-env.sh ${SIMUNE_PYTHON_VERSIONS}

# Define the container name
ENV NAME hypermodern-focal

# Open a terminal when the container launches
CMD ["/bin/bash", "-login"]
