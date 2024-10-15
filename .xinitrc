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

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login &


# --- The following lines make the final details for basic/minimum configuration of xmonad

# Set up an icon tray, do it with tray or stalonetray

#stalonetray -display :0 &

#trayer --edge top --align right --SetDockType true --SetPartialStrut true \
# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 \
# --monitor 1 &


# Set the default X cursor to the usual pointer
xsetroot -cursor_name left_ptr

# Set a nice background
nitrogen --restore &
#feh --bg-center --no-fehbg ~/Pictures/webb-telescope-image-1.png # webb-telescope-image-1.png
#feh --bg-fill --no-fehbg /home/frisk/Pictures/New_Kang_Inkyung/DJAWA\ Photo\ -\ Kang\ In-kyung\ \(강인경\)\ -\ “Masked\ Pirate”/DJAWA-Photo-Kang-In-kyung-Masked-Pirate-\ \(16\).jpg

# Fire up screensaver
xscreensaver -no-splash &

# Power Management
xfce4-power-manager &

# ibus-deamon
ibus-daemon &

if [ -x /usr/bin/nm-applet ] ; then
    nm-applet --sm-disable &
fi


#exec openbox-session
sleep 1 && xcompmgr &
exec xmonad 

# run compositing for xmonad
