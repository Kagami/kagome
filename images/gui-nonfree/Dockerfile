FROM gui

RUN apt-get install -y flashplugin-installer
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
    echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list &&\
    apt-get update &&\
    apt-get install -y google-chrome-unstable
RUN sudo -u user mkdir -p /home/user/.config/google-chrome-unstable/
RUN apt-get clean
