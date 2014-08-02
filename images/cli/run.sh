#!/bin/bash

set -e

USER="user"
sudo_passwd="`pwgen -s -N1 20`"
echo "$USER:$sudo_passwd" | chpasswd
echo "@@@ CONTAINER SUDO PASSWORD: $sudo_passwd @@@"
unset sudo_passwd
rm "$0"
exec sudo -u "$USER" -i
