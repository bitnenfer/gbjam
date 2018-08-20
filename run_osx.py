#!/usr/bin/python

import os

# Disable Wine debug warnings
os.environ["WINEDEBUG"] = "-all"

bgb = "wine ../bgb/bgb.exe -rom ./build/rom.gb"
bgbd = "wine ../bgb/bgb.exe -br PlayerUpdateBullets -rom ./build/rom.gb"

os.system(bgb);
# os.system(bgb + " -connect 127.0.0.1 & ");
# os.system(bgb + " -listen 127.0.0.1 & ");

