#!/bin/sh

YTFZF_HIST=0 # history is on by default it can be set to -> 0 history off, 1: history on
YTFZF_LOOP=0 # if set to 1 it is on but normally it is off by default. Can be turned on using option -l
YTFZF_PREF="bestvideo[height<=?1080]+bestaudio/best" # set the video format
YTFZF_ENABLE_FZF_DEFAULT_OPTS=1 # fzf colors are going to be the one from your fzf configuration
#FZF_PLAYER="vlc" # sets the video player used by ytfzf (mpv by default), e.g. FZF_PLAYER="devour mpv"; you can also specify the YTFZF_PLAYER_FORMAT, e.g. YTFZF_PLAYER_FORMAT="devour mpv --ytdl-format="
## player settings (players need to support streaming with youtube-dl)
#player to use for watching the video
#YTFZF_PLAYER="${YTFZF_PLAYER-vlc}"
#if YTFZF_PREF is specified, use this player instead
#YTFZF_PLAYER_FORMAT="${YTFZF_PLAYER_FORMAT-vlc --ytdl-format=}"

#use vlc instead of mpv
video_player () {
    #check if detach is enabled
    case "$is_detach" in
      #disabled
      0) vlc "$@" ;;
      #enabled
      1) setsid -f vlc "$@" > /dev/null 2>&1 ;;
      esac
}
