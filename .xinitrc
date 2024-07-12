#!/bin/env bash

# # Run dunst
# if [ -x "$(command -v dunst)" ]; then
#   dunst &
# fi

# # Start compositor
# if [ -x "$(command -v xcompmgr)" ]; then
#   xcompmgr -f -I 0.03 &
# elif [ -x "$(command -v picom)" ]; then
#   picom &
# elif [ -x "$(command -v compton)" ]; then
#   compton &
# fi

# exec dwm

exec awesome
