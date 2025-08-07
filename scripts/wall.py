#!/usr/bin/env python3

import os
from pathlib import Path
import random
import sys

WALLPAPER_DIR = "/home/dm/.config/000_wallpapers"

def main():
    # Get list of wallpapers
    wallpapers = [str(p) for p in Path(WALLPAPER_DIR).glob('**/*.jpg')]
    
    if not wallpapers:
        print("No wallpaper files found.", file=sys.stderr)
        sys.exit(1)
    
    random_wallpaper = random.choice(wallpapers)
    pid = os.fork()
    
    if pid == 0:
        os.execvp('wbg', ['wbg', '-s', random_wallpaper])
    else:
        os._exit(0)

if __name__ == "__main__":
    main()