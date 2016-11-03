#!/bin/bash

# Installs packages needed for C++ development.

set -x

# install packages
apt-get install --fix-missing -y --force-yes \
  build-essential \
  gcc-doc \
  clang \
  libboost-all-dev \
  libgtest-dev \
  autoconf \
  automake \
  libtool \
  cmake \
  doxygen \
  gdb \
  valgrind \
  ltrace \
  strace \
  git \
  gitk


# vim: set ts=2 sw=2 et:


