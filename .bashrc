#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export QT_STYLE_OVERRIDE=kvantum
export QT_QPA_PLATFORM_THEME=qt6ct
export GTK_THEME=Material-Black-Blueberry
PS1='[\u@\h \W]\$ '
