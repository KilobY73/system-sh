#!/bin/sh
if [ $@ = "up" ]; then
  set -- $(pactl get-sink-volume @DEFAULT_SINK@)
  vol=$((${5%'%'} + 10))
  if [ $vol -le 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ +10%
  fi
elif [ $@ = "down" ]; then
  pactl set-sink-volume @DEFAULT_SINK@ -10%
else
  pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

psdata=$(ps -A -o comm -o pid)
set -- ${psdata#*'status.sh'}
kill -9 -$1
exec status.sh
