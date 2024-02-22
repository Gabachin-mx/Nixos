#!/usr/bin/env bash

#brightnessctl | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ printf "brightness = ""%d\n",$2} '| while read OUTPUT; do notify-send -r 6900 "$OUTPUT"%""; done

brightnessctl | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ printf "brightness = "$1} '| while read OUTPUT; do notify-send -r 6900 "$OUTPUT"; done

#brightnessctl | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ printf "brightness = "$1} '| while read OUTPUT; do dunstify "$OUTPUT"; done



