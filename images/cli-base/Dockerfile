FROM base

RUN apt-get install -y build-essential valgrind strace man git vim zsh tmux curl netcat software-properties-common python htop psmisc python-libxml2 libxml2-utils unzip sqlite3 chromium-browser firefox xvfb ack-grep python-virtualenv
RUN dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
RUN curl -s https://static.rust-lang.org/rustup.sh | sudo sh
RUN apt-add-repository -y ppa:chris-lea/node.js && apt-get update && apt-get install -y nodejs
# pygrapviz dev
# RUN apt-add-repository -y ppa:fkrull/deadsnakes && apt-get update && apt-get install -y python-tox graphviz libgraphviz-dev pkg-config python2.6-dev python2.7-dev python3.2-dev python3.3-dev python3.4-dev && pip install tox
RUN apt-get clean
