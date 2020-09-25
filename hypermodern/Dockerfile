# Use an official Ubuntu runtime as a base image
FROM ubuntu:20.04

ARG SIMUNE_PYTHON_VERSIONS="3.8.5 3.7.9 3.6.12"

# Install the required development packages
ENV DEBIAN_FRONTEND=noninteractive
COPY packages-system.txt ./
COPY packages-python.txt ./
RUN apt-get update -y && \
    apt-get install apt-utils -y && \
    apt-get upgrade -y && \
    /bin/bash -c "xargs -a <(awk '/^\s*[^#]/' packages-system.txt) -r -- apt-get install -y" && \
    /bin/bash -c "xargs -a <(awk '/^\s*[^#]/' packages-python.txt) -r -- apt-get install -y --no-install-recommends" && \
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

# Create a non-privileged user
RUN adduser --home /hypermodern --disabled-password --gecos '' hypermodern
WORKDIR /hypermodern
USER hypermodern
ENV HOME /hypermodern

# Install Poetry
RUN (curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python) && \
    echo '. "${HOME}/.poetry/env"' >>${HOME}/.bash_profile

# Install Pyenv
RUN (curl -sSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash) && \
    echo 'export PYENV_ROOT="${HOME}/.pyenv"' >>${HOME}/.bash_profile && \
    echo 'export PATH="${PYENV_ROOT}/bin:${PATH}"' >>${HOME}/.bash_profile && \
    echo 'eval "$(pyenv init -)"' >>${HOME}/.bash_profile && \
    echo 'eval "$(pyenv virtualenv-init -)"' >>${HOME}/.bash_profile

# Install the desired versions of Python
COPY requirements-hypermodern.txt ./
RUN . "${HOME}/.bash_profile" && \
    for version in ${SIMUNE_PYTHON_VERSIONS}; do \
      pyenv install "${version}"; \
      pyenv rehash; \
    done && \
    pyenv local ${SIMUNE_PYTHON_VERSIONS}

# Install the tooling
RUN . "${HOME}/.bash_profile" && \
    for version in ${SIMUNE_PYTHON_VERSIONS}; do \
      pyenv shell "${version}" && \
      pip install -r requirements-hypermodern.txt && \
      pyenv shell --unset; \
    done

# Create a virtual environment for GUI development
COPY constraints-gui.txt ./
COPY requirements-gui.txt ./
RUN . "${HOME}/.bash_profile" && \
    pyenv virtualenv $(echo "${SIMUNE_PYTHON_VERSIONS}" | awk '{print $1}') gui-dev && \
    pyenv activate gui-dev && \
    pip install -r requirements-hypermodern.txt && \
    pip install -c constraints-gui.txt -r requirements-gui.txt && \
    pyenv deactivate && \
    pyenv virtualenvs

# Define the container name
ENV NAME hypermodern-focal

# Open a terminal when the container launches
CMD ["/bin/bash", "-login"]
