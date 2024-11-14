#!/bin/sh 

# Set themes
export QT_QPA_PLATFORMTHEME=qt6ct
export GTK_THEME=Material-Black-Blueberry
gsettings set org.gnome.desktop.interface gtk-theme 'Material-Black-Blueberry'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

exec leftwm
