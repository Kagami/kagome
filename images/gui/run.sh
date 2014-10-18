#!/bin/bash

set -e

USER="user"
APP="$*"

sudo_passwd="`pwgen -s -N1 20`"
echo "$USER:$sudo_passwd" | chpasswd
echo "@@@ CONTAINER SUDO PASSWORD: $sudo_passwd @@@"
unset sudo_passwd

# Fix sound permissions if sound available.
if [[ -e /dev/snd/timer ]]; then
    audio_gid="`stat -c %g /dev/snd/timer`"
    groupmod -g "$audio_gid" audio
    gpasswd -a user audio
fi

sudo -u "$USER" -i <<EOF
openbox-session &>openbox.log &
$APP &>gui.log &
sleep 2
setxkbmap -layout us,ru -option grp:toggle,ctrl:swapcaps,compose:rwin
xset r rate 300 50
EOF
exec sudo -u "$USER" -i
