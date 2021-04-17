#
# Makefile for the hypermodern Docker image
#

hypermodern_version = 1.2.0

hypermodern_srcs = \
  Dockerfile \
  hypermodern-constraints.txt \
  hypermodern-requirements.txt \
  install-hypermodern-env.sh \
  load-hypermodern-env.sh \
  packages-pytestqt.txt \
  packages-python.txt \
  packages-system.txt \
  show-current-env.sh

hypermodern_tag = pouillon/python:hypermodern-focal-$(hypermodern_version)

DEBUG ?= 0
ifeq ($(DEBUG),1)
  docker_opts = --progress=plain
else
  docker_opts = --progress=auto
endif

# Only give instructions to the user by default
all all_targets default: hypermodern-image

hypermodern-image: $(hypermodern_srcs)
	DOCKER_BUILDKIT=1 \
	  docker build $(docker_opts) --tag $(hypermodern_tag) .

upload: hypermodern-image
	docker push $(hypermodern_tag)

clean distclean:
	@echo "Nothing to do."

.PHONY: all all_targets clean default distclean hypermodern-image upload
