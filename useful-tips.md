# NVIDIA and xrandr troubleshooting
In a new fresh install just the main laptop monitor showed up in xradr but not HDMI output (didn't matter if was connected or not).
First of all just installed ```nouveau``` drivers but didn't work, then installed official ```nvidia``` drivers and did the configuration steps:
- ```# X -configure```
When the above didn't work tried the following:
- ```# nvidia-xconfig```

But hey, it didn't work, so just did some other stuff like manually creating and setting ```/etc/X11/xorg.conf.d/20-nvidia-video``` but also didn't work.

And at some point of figuring out what to do HDMI kind of "worked" but wasn't detect or recognized by ```xrandr``` (I could move the mouse/pointer to mi HDMI monitor but nothing was showed in that monitor).

Finally just figured out to uninstall intel drivers ```xf86-intel-video``` to just ```nvidia``` stay and HDMI started working but the main monitor didn't do.

So thought that HDMI is linked only to NVIDIA and main laptop monitor can only be managed by Intel. And then just appear like the following order of installing and configure things works:
- Install ```nvidia``` drivers
- Install ```xf86-intel-video``` drivers
- Configure ```# nvidia-xconfig```
