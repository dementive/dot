#!/bin/bash

which fzf &>/dev/null || { echo "Error: fzf is not installed"; exit 1; }
which rg &>/dev/null || { echo "Error: ripgrep is not installed"; exit 1; }
which bat &>/dev/null || { echo "Error: bat is not installed"; exit 1; }
which code-oss &>/dev/null || { echo "Error: code-oss is not installed"; exit 1; }

fzf \
    --disabled \
    --query "${1:-}" \
    --no-scrollbar \
    --style full \
    --bind "start:reload:rg --glob '!flecs.h' --glob '!flecs.c' --iglob '!/build/*' --iglob '!/licenses/*' --glob '!*.import' --glob '!*.tres' --glob '!*.uid' --glob '!*.godot' --glob '!*.tscn' --column --line-number --no-heading --smart-case {q}" \
    --bind "change:reload:sleep 0.1; rg --glob '!flecs.h' --glob '!flecs.c' --iglob '!/build/*' --iglob '!/licenses/*' --glob '!*.import' --glob '!*.tres' --glob '!*.uid' --glob '!*.godot' --glob '!*.tscn' --column --line-number --no-heading --smart-case {q} || true" \
    --delimiter : \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --preview-window 'right,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become(code-oss --goto {1}:{2})'
