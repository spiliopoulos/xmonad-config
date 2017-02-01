#!/bin/bash

mute=$(pamixer --get-mute)
if $mute
then
  echo 0
else
  volume=$(pamixer --get-volume)
  echo $volume
fi

