Wallpaper slideshow using nitrogen and cron
```
# script for setting a wallpaper "slideshow" using cron
# set that with the next command: crontab -e
# this sets the same wallpaper on 2 displays
*/20 * * * * (export DISPLAY=:0.0 && /bin/date && export TMP_WLL=$(find /your/directory/path -type f | shuf -n1) && /bin/nitrogen --set-auto --head=0 $TMP_WLL && /bin/nitrogen --set-auto --head=1 $TMP_WLL --save) > /tmp/myNitrogen.log 2>&1
```
