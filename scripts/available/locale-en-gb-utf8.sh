#!/bin/bash

# Installs en_GB UTF-8 locale.

set -x

# install packages
apt-get install --fix-missing -y --force-yes \
  locales-all \
  locales

# update locales
update-locale LANGUAGE="en_GB:en" LANG="en_GB.utf8"


# vim: set ts=2 sw=2 et:


