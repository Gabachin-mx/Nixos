{ config, pkgs, ... }:
{
programs.tmux = {
    enable = true;
    tmuxp.enable = false;
    historyLimit = 500000;
    shortcut = "s";
    extraConfig = ''
      set -g base-index 1
      set -g pane-base-index 1

      set -g status-keys vi
      setw -g mode-keys vi
      setw -g mouse on
      setw -g monitor-activity on

# Send prefix
      set-option -g prefix C-x
      unbind-key C-x
      bind-key C-x send-prefix

# Mouse mode
      setw -g mouse on
     
# Set easier window split keys
      bind-key v split-window -h
      bind-key h split-window -v

      # Moving between windows.
      unbind [
      unbind ]
      bind -r [ select-window -t :-
      bind -r ] select-window -t :+

      # Pane resizing.
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Maximize and restore a pane.
      unbind Up
      bind Up new-window -d -n tmp \; swap-pane -s tmp.1 \; select-window -t tmp
      unbind Down
      bind Down last-window \; swap-pane -s tmp.1 \; kill-window -t tmp

      # Log output to a text file on demand.
      bind P pipe-pane -o "cat >>~/#W.log" \; display "Toggled logging to ~/#W.log"

      # -- display -------------------------------------------------------------------
      # tabs
      #set -g window-status-current-format "#[fg=black]#[bg=red] #I #[bg=brightblack]#[fg=brightwhite] #W#[fg=brightblack]#[bg=black]"
      #set -g window-status-format "#[fg=black]#[bg=yellow] #I #[bg=brightblack]#[fg=brightwhite] #W#[fg=brightblack]#[bg=black]"

      ## status bar
      #set-option -g status-position bottom
      #set-option -g status-justify left
      #set -g status-fg colour1
      #set -g status-bg colour0
      #set -g status-left ' '
      #set -g status-right '#(date +"%_I:%M")'
      #set-option -g set-titles on
      ##256 colors
      #set -g default-terminal "xterm-256color"
      #set -ga terminal-overrides ",xterm-256color:Tc"
      ##Don't auto remane windows
      #set-option -g allow-rename off
      ## Source config
      #unbind r
      #bind r source-file ~/.tmux.conf \; display "Finished sourcing ~/.tmux.conf ."

# Toggle statusbar
bind-key s set-option status

# Refresh status line every 30 seconds - any lower and the CPU freaks out
set -g status-interval 30

# Start window and pane indices at 1.
set -g base-index 1
set -g pane-base-index 0

# Length of tmux status line
set -g status-left-length 30
set -g status-right-length 150

set-option -g status "on"

# Default statusbar color
set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

# Default window title colors
set-window-option -g window-status-style bg=colour214,fg=colour237 # bg=yellow, fg=bg1

# Default window with an activity alert
set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

# Active window title colors
set-window-option -g window-status-current-style bg=red,fg=colour237 # fg=bg1

# # Set active pane border color
# set-option -g pane-active-border-style fg=colour214
# 
# # Set inactive pane border color
# set-option -g pane-border-style fg=colour239

# Message info
set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

# Writing commands inactive
set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

# Pane number display
set-option -g display-panes-active-colour colour1 #fg2
set-option -g display-panes-colour colour237 #bg1

# Clock
set-window-option -g clock-mode-colour colour109 #blue

# Bell
set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg


set-option -g status-left "\
#[fg=colour223, bg=colour237]#{?client_prefix,#[bg=colour237],} ❐ #S \
#[fg=colour223, bg=colour237]#{?client_prefix,#[fg=colour237],}#{?window_zoomed_flag, 🔍,}"

set-option -g status-right "\
#[fg=colour223, bg=colour237] \
#[fg=colour223, bg=colour237] #(~/.local/bin/memory) \
#[fg=colour223, bg=colour237] #(~/.local/bin/cpu_percentage) \
#[fg=colour223, bg=colour237] #(~/.local/bin/temp1) \
#[fg=colour223, bg=colour237]  %b %d '%y\
#[fg=colour223]  %H:%M \
#[fg=colour223, bg=colour237]"

set-window-option -g window-status-current-format "\
#[fg=colour223, bg=colour237]\
#[fg=colour223, bg=colour237] #I* \
#[fg=colour223, bg=colour237, bold] #W \
#[fg=colour223, bg=colour237]"

set-window-option -g window-status-format "\
#[fg=colour237,bg=colour239,noitalics]\
#[fg=colour223,bg=colour239] #I \
#[fg=colour223, bg=colour239] #W \
#[fg=colour239, bg=colour237]"


      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # allow fn+left/right
      bind-key -n Home send Escape "OH"
      bind-key -n End send Escape "OF"

      setw -g monitor-activity off
      setw -g monitor-activity on
      set-option -g bell-action none
    '';
  };

}
