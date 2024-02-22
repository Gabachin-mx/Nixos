#!/usr/bin/env bash

# Manage logout with rofi
option=`echo -e "suspend\nlock screen\nlogout\nreboot\npoweroff\nKill user $USER" | rofi -width 600 -dmenu -p system:`
case $option in
    suspend)
        sudo systemctl  suspend
        ;;
    'lock screen')
        i3lock -i /home/paul/Backgounds/wood.png
        ;;
    logout)
        i3-nagbar -t warning -m 'Are you sure you  want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'
        ;;
    reboot)
       shutdown.sh && reboot
        ;;
       poweroff)
       shutdown.sh && poweroff
        ;;
    'kill user $USER')
        loginctl kill-user $USER
        ;;
esac
