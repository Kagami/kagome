FROM ubuntu

RUN locale-gen en_US.UTF-8 en_GB.UTF-8
ENV LANG en_US.UTF-8
RUN echo 'Europe/Moscow' > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN useradd user --shell /bin/bash --user-group --create-home --skel /dev/null
RUN gpasswd -a user sudo
RUN sed -i 's/^UMASK.*/UMASK 077/;s/^USERGROUPS_ENAB.*/USERGROUPS_ENAB no/' /etc/login.defs
RUN echo 'Defaults umask=0777' > /etc/sudoers.d/umask && chmod 440 /etc/sudoers.d/umask

RUN sed -i 's/archive\.ubuntu\.com/mirror.yandex.ru/;s/universe/universe multiverse/' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y pwgen wget
