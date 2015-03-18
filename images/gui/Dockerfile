FROM gui-base

RUN echo 'export DISPLAY=:0' >> /home/user/.profile
RUN echo 'export GTK_IM_MODULE=xim' >> /home/user/.profile
RUN echo 'export QT_IM_MODULE=xim' >> /home/user/.profile
ADD .XCompose /home/user/
RUN mkdir /tmp/.X11-unix/

RUN sudo -u user mkdir -p /home/user/.config/openbox/
ADD *.xml /home/user/.config/openbox/
RUN chown -R user:user /home/user/.config/openbox/
RUN sudo -u user mkdir -p /home/user/.config/gajim/ /home/user/.local/share/gajim/
RUN sudo -u user mkdir -p /home/user/.config/transmission/
RUN sudo -u user mkdir -p /home/user/.config/chromium/
RUN sudo -u user mkdir -p /home/user/.gnupg/
RUN sudo -u user mkdir -p /home/user/shared/

ADD run.sh /home/user/
RUN chmod 755 /home/user/run.sh
ENTRYPOINT ["/home/user/run.sh"]
