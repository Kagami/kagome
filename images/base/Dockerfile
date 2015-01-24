FROM ubuntu

RUN locale-gen en_US.UTF-8 en_GB.UTF-8
RUN echo 'export LANG=en_US.UTF-8' >> /root/.profile
RUN echo 'export LC_TIME=en_GB.UTF-8' >> /root/.profile
RUN echo 'Europe/Moscow' > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN useradd user --shell /bin/bash --user-group --create-home --skel /dev/null
RUN echo 'export LANG=en_US.UTF-8' >> /home/user/.profile
RUN echo 'export LC_TIME=en_GB.UTF-8' >> /home/user/.profile
RUN gpasswd -a user sudo
RUN sed -i 's/^UMASK.*/UMASK 077/;s/^USERGROUPS_ENAB.*/USERGROUPS_ENAB no/' /etc/login.defs
RUN echo 'Defaults umask=0777' > /etc/sudoers.d/umask && chmod 440 /etc/sudoers.d/umask

RUN sed -r -i 's#http://archive\.ubuntu\.com/ubuntu/ (trusty|trusty-updates|trusty-backports) #mirror://mirrors.ubuntu.com/mirrors.txt \1 #' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y pwgen wget software-properties-common && apt-get clean
