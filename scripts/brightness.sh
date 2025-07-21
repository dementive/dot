#!/bin/sh

case ${1} in
up)
    brightnessctl -s s +5%;;
down)
    brightnessctl -s s 5%-;;
esac
