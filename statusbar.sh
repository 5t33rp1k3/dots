#!/bin/bash

# dwm status bar info script ~/.statusbar.sh

volume() {
  vol=$(amixer get Master | sed -n 'N;s/^.*\[\([0-9]\+%\).*$/\1/p')
  mute=$(amixer get Master | grep 'off')
  if [ ! -z "$mute" ]; then
    volsym='M'
  fi
  echo "$volsym$vol"
}

battery() {
  batcap=$(cat /sys/class/power_supply/BAT0/capacity)
  batstat=$(cat /sys/class/power_supply/BAT0/status)
  if [[ $batstat = "Charging" ]]; then
    batsym='+'
  else
    batsym='%'
  fi
  echo "$batcap$batsym"
}

clock() {
  date +"%a %d %b · %H:%M"
}

while true; do
  xsetroot -name "V $(volume) · B $(battery) · $(clock) "
  sleep 10
done
