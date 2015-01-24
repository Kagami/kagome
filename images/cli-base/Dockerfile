FROM base

RUN apt-add-repository -y ppa:chris-lea/node.js && apt-get update
RUN apt-get install -y build-essential valgrind strace man git vim zsh tmux curl netcat python htop psmisc python-libxml2 libxml2-utils unzip sqlite3 chromium-browser firefox xvfb ack-grep python-virtualenv nodejs
RUN dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
RUN curl -s https://static.rust-lang.org/rustup.sh | sudo sh
RUN apt-get clean
