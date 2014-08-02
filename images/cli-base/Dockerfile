FROM base

RUN apt-get install -y build-essential strace man git vim zsh tmux curl wget netcat software-properties-common
RUN curl http://www.rust-lang.org/rustup.sh | bash
RUN apt-add-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get clean
