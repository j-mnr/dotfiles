#!/bin/sh

DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/"$(pidof i3)"/environ | cut -d= -f2-)
export DBUS_SESSION_BUS_ADDRESS

case "$1" in
  1)
    notify-send -u critical -h string:fgcolor:#be97c6 -h string:bgcolor:#2e294e -h string:frcolor:#8661c1 "$(figlet -w 40 'Frontend Mentor')"
    ;;
  2)
    notify-send -i ~/src/go/gophergo.dev/static/favicon.ico -u critical -h string:fgcolor:#be97c6 -h string:bgcolor:#2e294e -h string:frcolor:#8661c1 "$(figlet -w 40 'GopherGo Time')"
    ;;
  3)
    notify-send -u critical -h string:fgcolor:#be97c6 -h string:bgcolor:#2e294e -h string:frcolor:#8661c1 "$(figlet -w 40 'Meditate')"
    ;;
esac

