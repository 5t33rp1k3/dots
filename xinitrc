#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# dwm status bar info
while true; do
  batcap=$(cat /sys/class/power_supply/BAT0/capacity)
  batstat=$(cat /sys/class/power_supply/BAT0/status)
  if [ $batstat = "Full" ]; then
    batsym="#"
  elif [ $batstat = "Charging" ]; then
    batsym="+"
  else
    batsym="%"
  fi
  volume=$(amixer get Master | sed -n 'N;s/^.*\[\([0-9]\+%\).*$/\1/p')
  calendar=$(date +"%a %d %b")
  time=$(date +"%H:%M")
  xsetroot -name " [B:$batcap$batsym] [V:$volume] [$time] [$calendar]"
  sleep 30
done &

# start at login
amixer sset Master 0% &
thunar --daemon &
xset -b &
feh --bg-fill ~/Pictures/wallpaper.png &
setxkbmap -option 'ctrl:nocaps' &
compton -b &
[ ! -s ~/.config/mpd/mpd.pid ] && mpd &

# start dwm
exec dwm
