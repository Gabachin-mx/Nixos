#!/bin/bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg


amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ print "vol = "$3 }' | while read OUTPUT; do notify-send -u normal -i $NOTIFY_ICON \ "$OUTPUT"; done


