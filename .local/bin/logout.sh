#!/usr/bin/env bash
# Manage logout with rofi
option=`echo -e "suspend\nlock screen\nlogout\nreboot\npoweroff\nKill user $USER" | rofi -width 600 -dmenu -p system:`
case $option in
    suspend)
        sudo systemctl  suspend
        ;;
    'lock screen')
        i3lock -i /home/koromicha/Pictures/linuxtux.png
        ;;
    logout)
        i3-nagbar -t warning -m 'Are you sure you  want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'
        ;;
    reboot)
      pactl set-sink-volume @DEFAULT_SINK@ 50% && mpv /home/paul/.config/i3/shutdown.mp3 &&  reboot
        ;;
    poweroff)
       pactl set-sink-volume @DEFAULT_SINK@ 50% && mpv /home/paul/.config/i3/shutdown.mp3 && poweroff
        ;;
    'kill user $USER')
        loginctl kill-user $USER
        ;;
esac