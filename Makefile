#
# Makefile for the Docker images to produce documentation on Debian
#

hypermodern_srcs = \
  hypermodern/Dockerfile \
  hypermodern/app-constraints.txt \
  hypermodern/app-requirements.txt \
  hypermodern/hypermodern-constraints.txt \
  hypermodern/hypermodern-env.sh \
  hypermodern/hypermodern-requirements.txt \
  hypermodern/install-app-env.sh \
  hypermodern/install-hypermodern-env.sh \
  hypermodern/packages-python.txt \
  hypermodern/packages-system.txt

all all_targets default: hypermodern-image

hypermodern-image: $(hypermodern_srcs)
	cd hypermodern && docker build -t pouillon/python:hypermodern-focal-latest .

upload: hypermodern-image
	docker push pouillon/python:hypermodern-focal-latest

clean:
	@echo "Nothing to do."

.PHONY: all all_targets clean default hypermodern-image upload
