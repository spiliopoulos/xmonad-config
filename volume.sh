#!/bin/bash

mute=$(pamixer --get-mute)
if $mute
then
  echo "Mute"
else
  volume=$(pamixer --get-volume)
  echo  "$volume / 10" | bc
fi

