FROM cli-base

ENV TERM xterm-256color
RUN chsh -s /bin/zsh user
ADD run.sh /
ENTRYPOINT ["/run.sh"]
