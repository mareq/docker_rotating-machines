#!/bin/bash

# Sets up vim-like user environment.

set -x

# install packages
apt-get install --fix-missing -y --force-yes \
  git \
  screen \
  vim \
  exuberant-ctags

# get configuration files from GitHub
git clone https://github.com/mareq/skel.git /root/skel
sed --in-place=".orig" 's/name = Mareq/name = user/' /root/skel/.gitconfig
sed --in-place=".orig" 's/email = mareq@balint.eu/email = user@example.tld/' /root/skel/.gitconfig

# root environment
mv /root/.bashrc /root/.bashrc.orig
cp /root/skel/.bashrc_root /root/.bashrc
cp /root/skel/.inputrc /root/.
cp /root/skel/.screenrc /root/.
cp /root/skel/.vimrc /root/.
cp -r /root/skel/.vim /root/.

# default user environment
mv /etc/skel/.bashrc /etc/skel/.bashrc.orig
cp /root/skel/.bashrc /etc/skel/.
cp /root/skel/.bash_aliases /etc/skel/.
cp /root/skel/.tcshrc /etc/skel/.
cp /root/skel/.inputrc /etc/skel/.
cp /root/skel/.screenrc /etc/skel/.
cp /root/skel/.vimrc /etc/skel/.
cp -r /root/skel/.vim /etc/skel/.
cp /root/skel/.gitconfig /etc/skel/.

cat <<EOF >> /etc/motd

IMPORTANT: The shell is in vi mode. This is largely non-standard and has
           potential to make command line completely unusable to someone
           not familiar with vi. If you wish to switch back to emacs mode,
           which is usually the default, execute the following command
           as the very first thing you do: set -o emacs
EOF


# vim: set ts=2 sw=2 et:


