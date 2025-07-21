## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -Ua fish_features no-keyboard-protocols # fixes sublime-text bug: https://forum.sublimetext.com/t/latest-dev-builds-broke-terminus-with-fish-shell/75587/6

## Export variable need for themes
set -x GTK_THEME Material-Black-Blueberry
set -x QT_STYLE_OVERRIDE kvantum
set -x QT_QPA_PLATFORM_THEME qt6ct

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

set -U EDITOR subl4

# Godot shared library loading
export LD_LIBRARY_PATH="/home/dm/dev/godot/bin"

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

function fish_prompt
    string join '' -- (set_color green) (prompt_pwd --full-length-dirs 50) (set_color normal) ' '
end

# Fzf commands:
# (alt+c) to use as cd.
# (ctrl+r) to browse command histroy
fzf --fish | source

# Ctrl T to browse files and open selected ones in sublime
set -U FZF_CTRL_T_OPTS "
  --no-scrollbar
  --style full
  --preview='bat --color=always {}'
  --bind 'start:reload:fd --fixed-strings --type f'
  --bind 'enter:execute(subl4 {})'"

set -U FZF_ALT_C_OPTS "
  --no-scrollbar
  --style full
  --bind 'start:reload:fd --fixed-strings --type d'"

bind ctrl-f "fzf --disabled --no-scrollbar --style full --bind 'start:reload:rg --column --line-number --no-heading --smart-case {q}' --bind 'change:reload:sleep 0.1; rg --column --line-number --no-heading --smart-case {q} || true' --delimiter : --preview 'bat --color=always {1} --highlight-line {2}' --preview-window 'right,60%,border-bottom,+{2}+3/3,~3' --bind 'enter:execute(subl4 {1}:{2})'"

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes --style header'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias subl="subl4"
alias e="exit"
alias c="clear"

alias xbi="sudo xbps-install"
alias xbu="sudo xbps-install -Su"
alias xbs="xbps-query -Rs"
alias xbd="sudo xbps-remove -Oo"

alias bd="./bd.py"
alias run="./run.sh"
