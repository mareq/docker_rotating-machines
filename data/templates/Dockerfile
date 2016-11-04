# start from standard Debian
FROM debian

# update the system
RUN sed --in-place=".orig" 's/\(deb\(-src\)\?\s\s*[^\s][^\s]*\s\s*\w\w*\)\s\s*main\s*/\1 main contrib non-free/' /etc/apt/sources.list
RUN apt-get -q update && apt-get -q --fix-missing -y --force-yes upgrade

# set up SSH server
RUN apt-get install --fix-missing -y --force-yes openssh-server
EXPOSE 22

# allow remote SSH by root with password toor
RUN echo 'root:toor' | chpasswd
RUN sed --in-place=".orig" 's/PermitRootLogin\s\s*\w\w*$/PermitRootLogin yes/' /etc/ssh/sshd_config

# workaround for known bug: 
# - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=760422
# - https://bugs.launchpad.net/ubuntu/+source/openssh/+bug/45234
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

# workaround for known bug:
# - https://github.com/docker/docker/issues/5554
# - https://github.com/docker/docker/issues/5663
RUN sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd

@@scripts@@

# run SSH server in container, so that it is possible to SSH into it
CMD ["/usr/sbin/sshd", "-D"]


# vim: set ts=2 sw=2 et:


