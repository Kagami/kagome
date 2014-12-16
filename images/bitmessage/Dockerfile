FROM gui

RUN echo 'export QT_X11_NO_MITSHM=1' >> /home/user/.profile
RUN apt-get install -y python-qt4
RUN apt-get clean
RUN sudo -u user mkdir -p /home/user/.config/PyBitmessage/
COPY PyBitmessage /usr/local/PyBitmessage
