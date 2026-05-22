#!/bin/bash
last_orientation=""

monitor-sensor | while read -r line; do
  orientation=$(echo "$line" | grep -oP '(?<=Accelerometer orientation changed: )\S+')
  [ -z "$orientation" ] && continue
  [ "$orientation" = "$last_orientation" ] && continue
  last_orientation="$orientation"

  case $orientation in
    normal)
      hyprctl keyword monitor "eDP-1,preferred,auto,1,transform,0"
      hyprctl keyword input:touchdevice:transform 0 ;;
    bottom-up)
      hyprctl keyword monitor "eDP-1,preferred,auto,1,transform,2"
      hyprctl keyword input:touchdevice:transform 2 ;;
    left-up)
      hyprctl keyword monitor "eDP-1,preferred,auto,1,transform,1"
      hyprctl keyword input:touchdevice:transform 1 ;;
    right-up)
      hyprctl keyword monitor "eDP-1,preferred,auto,1,transform,3"
      hyprctl keyword input:touchdevice:transform 3 ;;
  esac
done
