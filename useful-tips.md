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

(Little update) All time HDMI automatically was set as primary -didn't matter if I just changed to be laptop monitor/eDP1 as primary, xrandr just didn't care and I wasn't able to see anything in display when just using the laptop, even when HDMI wasn't connected- but commenting this line in ```xorg.conf``` ```#    Device         "Device0"``` and adding another ```Monitor``` section (and giving a name/identifier to both ```Monitor``` sections) fixed, so related sections look like this:
```
Section "Monitor"
    Identifier     "eDP1"
    VendorName     "Unknown"
    ModelName      "Unknown"
    Option         "DPMS"
    Option	  "Primary" "true"
EndSection

Section "Monitor"
    Identifier     "HDMI-0"
    VendorName     "Unknown"
    ModelName      "Unknown"
    Option         "DPMS"
    Option	  "RightOf" "eDP1"
EndSection
Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BusID          "PCI:1:0:0"
    Option "UseHotplugEvents" "false"
EndSection

Section "Screen"
    Identifier     "Screen0"
#    Device         "Device0"
    Monitor        "eDP1"
    DefaultDepth    24
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
