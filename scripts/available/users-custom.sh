#!/bin/bash

# Creates user. This script defaults to noop, @@wildcards@@ need to be
# replaced by desired values and #@@ commented lines need to be uncommented.

set -x

# add default user
#@@ adduser --uid @@uid@@ --disabled-password --gecos "" @@username@@
#@@ echo '@@username@@:@@password@@' | chpasswd


# vim: set ts=2 sw=2 et:


