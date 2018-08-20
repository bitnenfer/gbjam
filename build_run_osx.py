#!/usr/bin/python

import os

result = os.system("python build_osx_gb.py")
if result == 0:
	os.system("python run_osx.py")
