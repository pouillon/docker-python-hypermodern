|badge_status| |badge_license|

.. |badge_status| image:: https://img.shields.io/github/workflow/status/pouillon/docker-images-python/Lint%20Dockerfile?label=lint

.. |badge_license| image:: https://img.shields.io/github/license/pouillon/docker-images-python?color=green


Docker Images for Python application development
================================================

This infrastructure package gathers the specifications of Docker images that
can be used to develop and test all sorts of Python-based applications.


Building the image
------------------

Please install Docker on your computer first. See
https://docs.docker.com/get-docker/ for details.

To build a custom image, just type:

::

    make hypermodern_tag=YOUR_TAG

where you replace ``YOUR_TAG`` by the label you want to use for the image. The
default tag is set for publication on the `original author's DockerHub
repository`_.

For more information about how to build and publish Docker images, please
consult the `official documentation of Docker`_.


Using the image
---------------

The image provides a container with pre-installed Python interpreters managed
with `pyenv`_. It is possible to install many more Python environments, please
consult the documentation of `pyenv`_ for details.

The rest of the environment is based on the `Hypermodern Python`_ turorial,
from Claudio Jolowicz. All the details about developing Python applications
within this framework are explained there. Most of the infrastructure relies
on `poetry`_ and `nox`_.


Contributing
------------

Contributions and customizations are welcome. Before changing anything, please
create an issue summarizing your intentions.


.. _`Hypermodern Python`: https://cjolowicz.github.io/posts/hypermodern-python-01-setup/
.. _`nox`: https://nox.thea.codes/en/stable/
.. _`official documentation of Docker`: https://docs.docker.com/
.. _`original author's DockerHub repository`: https://hub.docker.com/repository/docker/pouillon/python
.. _`poetry`: https://cjolowicz.github.io/posts/hypermodern-python-01-setup/
.. _`pyenv`: https://github.com/pyenv/pyenv
