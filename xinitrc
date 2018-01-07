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

feh --bg-fill ~/backgrounds/sombra-logo_4k.png &
.panel/panel.sh |& lemonbar -f "Liberation Mono:size=13" -f "Font Awesome 5 Free:size=13" -f "Font Awesome 5 Brands:size=13" &
compton -CGb -i 0.8 --backend glx --opacity-rule '75:name *= "urxvt"'&
sxhkd&
exec bspwm
