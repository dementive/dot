#!/bin/sh

if wlr-randr | grep 'HDMI-A-1'; then wlr-randr --output eDP-2 --off; fi