# configuration for a particular stats site
import os, sys

# the directory where the configuration files (e.g. usernames.txt) are stored, and where sitesettings.py is.
installDir = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
sys.path.append(installDir)
from sitesettings import *

downloaderDir = os.path.join(installDir, "downloader")
dbdir = os.path.join(installDir, "db")
resultdir= os.path.join(installDir, "static")
logfile = os.path.join(installDir, "downloader.log")

# a public file owned by drfriendless@gmail.com
#usernames_url = "https://pastebin.com/raw/BvvdxzcH"
usernames_url = "https://gist.githubusercontent.com/HolisticDeveloper/3e488ca8c5dc0f582274d52a661ff063/raw/e93ae664e3ea7889bc073241f3a485b43effa18e/bggusers.txt"

# a public file owned by drfriendless@gmail.com
metadata_url = "https://pastebin.com/raw/iS8idfaH"