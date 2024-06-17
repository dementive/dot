#!/bin/bash

wallpaper_dir="/home/dm/.config/000_wallpapers/"
random_num=$((RANDOM % 8 + 1))
wallpaper_path="${wallpaper_dir}${random_num}.jpg"
swaybg -i "$wallpaper_path"
