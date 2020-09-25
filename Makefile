#
# Makefile for the Docker images to produce documentation on Debian
#

hypermodern_srcs = \
  hypermodern/Dockerfile \
  hypermodern/constraints-gui.txt \
  hypermodern/packages-python.txt \
  hypermodern/packages-system.txt \
  hypermodern/requirements-gui.txt \
  hypermodern/requirements-hypermodern.txt

all all_targets default: hypermodern-image

hypermodern-image: $(hypermodern_srcs)
	cd hypermodern && docker build -t pouillon/python:hypermodern-focal .

upload: hypermodern-image
	docker push pouillon/python:hypermodern-focal

clean:
	@echo "Nothing to do."

.PHONY: all all_targets clean default hypermodern-image upload
