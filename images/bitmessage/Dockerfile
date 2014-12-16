FROM gui

ENV QT_X11_NO_MITSHM 1
RUN apt-get install -y python-qt4
RUN apt-get clean
RUN sudo -u user mkdir -p /home/user/.config/PyBitmessage/
COPY PyBitmessage /usr/local/PyBitmessage
