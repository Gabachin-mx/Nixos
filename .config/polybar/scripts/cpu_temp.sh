 #!/usr/bin/env bash
case "$1" in
    --popup)
        notify-send "CPU time (%)" "$(ps axch -o cmd:10,pcpu k -pcpu | head | awk '$0=$0"%"' )"
        ;;
    *)
        echo " $(grep 'cpu ' /proc/stat | awk '{cpu_usage=($2+$4)*100/($2+$4+$5)}
        END {printf "%{F#00ff00} %0.2f%", cpu_usage}')"
        ;;
esac
