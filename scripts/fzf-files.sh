#!/bin/bash

which fzf &>/dev/null || { echo "Error: fzf is not installed"; exit 1; }
which bat &>/dev/null || { echo "Error: bat is not installed"; exit 1; }
which fd &>/dev/null || { echo "Error: fd is not installed"; exit 1; }
which subl4 &>/dev/null || { echo "Error: sublime is not installed"; exit 1; }

fzf --no-scrollbar --style full --preview='bat --color=always {}' --bind 'start:reload:fd --fixed-strings --type f --exclude "*.tscn" --exclude "*.import" --exclude "*.uid" --exclude "*.tres" --exclude "*.godot"' --bind 'enter:become(subl4 {})'