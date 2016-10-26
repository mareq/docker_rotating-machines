# Docker Rotating Machines

## Introduction

It is potentially dangerous to develop directly on local machinge, since the code being worked on may do all kinds of unpredictable things. It becomes especially challenging at times, when the code under development has many dependencies, sometimes even conflicting with software installed on developer's machine. Therefore, it is considered a good practice to develop in isolation, on a machine dedicated to development of that particular piece of code. It should be as easy as possible for programmer to restore such machine to its original state in matter of seconds, hence the name "rotating machine", i.e. a machine that is very easy to "turn around". This relaxes limits of what programmer can try to do when exploring code, especially during bug fixing, because there is no risk of considerable downtime due to broken development environment.

Before Docker, there were other solutions for this problem available. Being based on full-fledged virtualization, these solutions were much more heavy-weight and resource-consumig. While Docker has been primarily designed for completely different purpose and it is even considered a bad habit to use SSH to connect to Docker containers in those situations, it proves itself very useful also for management of "rotating machines". This repository provides set of scripts for automation of tasks for building and managing such machines.

## Prerequisites

Since whole solution for "rotating machines" is built on top of Docker, it comes only natural [Docker](https://www.docker.com/) is needed. E.g. on Debian-like system, it can be easily installed just by typing:

    # apt-get install docker.io

In order to be able to run docker as normal user instead of root, which is very good idea, some additional changes are needed. See e.g. [this discussion forum](http://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo) for details.

## Fast HowTo

Clone the repository.

    $ git clone https://github.com/mareq/docker_rotating-machines.git

Run the build script. This can take approximately 10 minutes and will build docker image ```rotating-machine```.

    $ docker_rotating-machines/bin/drm-build

Run the start script. This will create and start new docker container named ```dryer```. Container's SSH port will be bound to port ```2222``` of the host machine.

    $ docker_rotating-machines/bin/drm-start dryer 2222

SSH to the ```dryer``` container that has just been created. The password is ```oenom```.

    $ ssh moneo@localhost -p 2222

Should you need root access for any reason, just ```su``` with password ```toor```. However, it may be good idea to provide custom script that will do the needed configuration during build of docker image (see below). In case you deem such a custom script generally usefull, please create a pull request.

## Reference

    docker_rotating-machines
      ├── README.md
      ├── bin
      │   ├── drm-build
      │   ├── drm-start      
      │   └── drm-reset-defaults
      └── scripts
          ├── Dockerfile
          ├── available
          │   ├── devel-cpp.sh
          │   ├── environment-vim.sh
          │   ├── users-default.sh
          │   └── users-custom.sh
          └── enabled
              ├── 10_locale-en-gb-utf8.sh -> ../available/locale-en-gb-utf8.sh
              ├── 20_devel-cpp.sh -> ../available/devel-cpp.sh
              ├── 30_environment-vim.sh -> ../available/environment-vim.sh
              ├── 40_users-default.sh -> ../available/users-default.sh
              └── 50_users-custom.sh -> ../available/users-custom.sh

### ```bin```

The ```bin``` directory contains scripts to be executed by user in order to automate various tasks while managing "rotating machines". It may be a good idea to add this directory to ```$PATH``` environment variable. All scripts accept command line argument ```--help```, which will print out detailed usage instructions.

- ```drm-build```: The script for building "rotating machine" docker image. This script will use whatever configuration present in ```scripts/enabled```.
- ```drm-start```: The script will create new docker container using already built image and bind its SSH port to specified port on host machine. It is therefore necessary to build the docker image (e.g. by running ```drm-build```) prior to running this script.
- ```drm-reset-defaults```: The script restores configuration of custom scripts, i.e. the default symlinks to ```scripts/available``` directory will be created in ```scripts/enabled``` directory. **BEWARE: THIS WILL DELETE ALL FILES PRESENT IN ```scripts/enabled``` DIRECTORY!**

### ```scripts```

Apart of ```Dockerfile``` that is used by ```drm-build``` script, this directory contains ```available``` and ```enabled``` directories. These work the same way as ```mods-available``` and ```mods-enabled``` directories in configuration of Apache web server. The ```available``` directory contains all custom scripts available and user is free to provide new ones as needed. In order for ```drm-build``` to use a custom script a symlink to that script needs to be placed in ```enabled``` directory. It may matter in which order these scripts get executed during build of docker image and therefore it is guaranteed that they will be executed in alphabetical order (e.g. ```20_environment-vim.sh``` will be executed prior to ```30_users-default.sh``` and therefore home directories of default users will contain rc-files configuring vim-like environment).

Currently, following custom scripts are available:
- ```locale-en-gb-utf8.sh```: Installs en_GB UTF-8 locale.
- ```devel-cpp.sh```: Installs packages needed for C++ development.
- ```environment-vim.sh```: Sets up vim-like environment.
- ```users-default.sh```: Creates default user named ```moneo``` with password ```oenom``` and disables remote root login.
- ```users-custom.sh```: Contains (commented out) boilerplate code for creation of custom users. It needs to be customized by hand in order to actually do something.


