FROM cli-base

RUN chsh -s /bin/zsh user
ADD run.sh /
ENV TERM xterm-256color
ENTRYPOINT ["/run.sh"]
