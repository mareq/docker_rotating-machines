#!/bin/bash

# Creates default user.

set -x

# add default user
adduser --uid 1024 --disabled-password --gecos "" moneo
echo 'moneo:oenom' | chpasswd

# disable remote root login
sed --in-place 's/PermitRootLogin\s\s*\w\w*$/PermitRootLogin without-password/' /etc/ssh/sshd_config


# vim: set ts=2 sw=2 et:


