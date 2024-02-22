function fish_title
       set -l command (status current-command)
    if test "$command" = alacritty
        echo "Alacritty"
    else
        echo $command
    end
end
