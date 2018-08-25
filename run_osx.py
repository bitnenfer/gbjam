#!/usr/bin/python

import os

# Disable Wine debug warnings
os.environ["WINEDEBUG"] = "-all"

bgb = "wine ../bgb/bgb.exe -rom ./build/rom.gb"
bgbd = "wine ../bgb/bgb.exe -br EnemyKill -rom ./build/rom.gb"

os.system(bgbd);
# os.system(bgb + " -connect 127.0.0.1 & ");
# os.system(bgb + " -listen 127.0.0.1 & ");

