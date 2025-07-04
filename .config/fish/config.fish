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


# Starship prompt
if status --is-interactive
   source ("/usr/bin/starship" init fish --print-full-init | psub)
end

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

## Useful aliases
# Replace ls with exa
#alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
#alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
#alias ll='exa -l --color=always --group-directories-first --icons' # long format
#alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
#alias l.='exa -ald --color=always --group-directories-first --icons .*' # show only dotfiles
alias ip='ip -color'

# Replace some more things with better alternatives
#alias cat='bat --style header --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias tarnow='tar -acf '
alias uptar='tar -acf '
alias untar='tar -xvf '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias hx='helix'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias pacman-clean='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

alias t="tldr"
alias l="ls -a"
alias c="clear"
alias e="exit"
# Full screenshot
alias fs="scrot -b '%Y:%m:%d:%H:%M:%S.png' -e 'mv $f ~/Pictures/'"
# Rectangle screenshot
alias rs="scrot --select -b '%Y:%m:%d:%H:%M:%S.png' -e 'mv $f ~/Pictures/'"
# Brightness
alias light="brightnessctl s +10%"
alias dark="brightnessctl s 10%-"
# Sound
alias sounddown="amixer -q set Master 10%-"
alias soundup="amixer -q set Master 10%+"

# gc build

alias bd="./bd.sh"
alias run="./run.sh"
