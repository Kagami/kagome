FROM cli-base

RUN chsh -s /bin/zsh user
RUN echo 'export TERM=xterm-256color' >> /home/user/.profile
ADD run.sh /
ENTRYPOINT ["/run.sh"]
