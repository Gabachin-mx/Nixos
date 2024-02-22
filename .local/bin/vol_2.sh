#!/usr/bin/env bash

showVol() {
    VOL="$(amixer get Master | egrep -o -m1 "[0-9]+%")"
    if test -e /tmp/vol-id ; then
        ARG="-r $(head -n 1 /tmp/vol-id)"
    else
        ARG=""
    fi
    if amixer get Master | grep -q off; then
        echo $(notify-send $ARG -p -u low "Muted") > /tmp/vol-id
    else
        echo $(notify-send $ARG -p -u low "Volume: $VOL") > /tmp/vol-id
    fi
}

volUp() {
    amixer -q set Master unmute
    amixer -q sset Master "2%+"
    
}
 
volDown() {
    amixer -q set Master unmute
    amixer -q sset Master "2%-"
}


# main part

case "$1" in
    "volup")
            volUp
            ;;
    "voldown")
            volDown
            ;;
    "mute")
            amixer -q set Master toggle
            ;;
    *)
            ;;
esac
showVol
