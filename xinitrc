#!/bin/sh

# ~/.xinitrc

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

feh --bg-fill ~/Pictures/wall.png & # set wallpaper
~/.statusbar.sh & # launch dwm status bar info script
amixer sset Master 50% &
thunar --daemon &
xset -b & # turn off the bell
setxkbmap -option 'ctrl:nocaps' & # map caps lock to control
compton -b &
[ ! -s ~/.config/mpd/pid ] && mpd & # launch mpd, if no pid file exists

# start dwm
exec dwm
