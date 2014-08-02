FROM gui-base

ENV DISPLAY :0
RUN mkdir /tmp/.X11-unix
# Applications settings.
RUN sudo -u user mkdir -p /home/user/.config/openbox/
RUN echo '\
    <openbox_config>\
        <applications>\
            <application class="Firefox" role="browser">\
                <maximized>yes</maximized>\
                <decor>no</decor>\
            </application>\
            <application class="Thunderbird" role="3pane">\
                <maximized>yes</maximized>\
                <decor>no</decor>\
            </application>\
            <application class="Gajim" role="roster">\
                <maximized>yes</maximized>\
                <decor>no</decor>\
            </application>\
        </applications>\
    </openbox_config>' | sudo -u user tee /home/user/.config/openbox/rc.xml
RUN sudo -u user mkdir -p /home/user/.config/gajim/ /home/user/.local/share/gajim/

ADD run.sh /home/user/
RUN chmod 755 /home/user/run.sh
ENTRYPOINT ["/home/user/run.sh"]
