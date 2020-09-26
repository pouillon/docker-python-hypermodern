https://img.shields.io/github/workflow/status/pouillon/docker-images-python/Lint%20Dockerfile?label=lint
https://img.shields.io/github/license/pouillon/docker-images-python?color=green

Docker Images for Python application development
================================================

This project gathers the specifications of Docker images that can be used in
Gitlab runners to build all sorts of Python-based applications.

Contributions and customizations are welcome. Before changing anything, please
create an issue summarizing your intentions for each image you wish to tweak.


Instructions
------------

Please install Docker on your computer (http://docker.io/) first.

To build an image, just go to the corresponding directory and type:

::

    docker build -t image_name .

where you replace image_name by the name of the image.

Hint: if you do not know which name to choose, just use the directory name
where the image is stored.

For convenience, you can also use the Makefile in the top source directory of
this repository.


Troubleshooting
---------------

Ubuntu 16.04 and later
~~~~~~~~~~~~~~~~~~~~~~

If you experience network timeouts when running ''docker build'' on Ubuntu
16.04 and later, you can use the following fix.

First, run the following command to get the IP addresses of your current DNS
servers:

::

    sudo nmcli dev show | grep IP4.DNS

You will get something like the following:

::

    IP4.DNS[1]:                             123.456.789.100
    IP4.DNS[2]:                             123.456.789.210

Then, edit /etc/docker/daemon.json (create the file if it does not exist yet)
and add the following (replace with your actual DNS servers):

::

    {                                                                          
        "dns": ["123.456.789.100", "123.456.789.210"]
    }

Finally, restart Docker:

::

    sudo service docker restart

