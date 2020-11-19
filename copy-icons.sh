#!/bin/bash
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

echo -e ${CYAN}
echo ' ___                      ____             _'
echo '|_ _|___ ___  _ __  ___  | __ )  __ _  ___| | ___   _ _ __'
echo ' | |/ __/ _ \|  _ \/ __| |  _ \ / _` |/ __| |/ / | | |  _ \'
echo ' | | (_| (_) | | | \__ \ | |_) | (_| | (__|   <| |_| | |_) |'
echo '|___\___\___/|_| |_|___/ |____/ \__,_|\___|_|\_\\__,_| .__/'
echo '                                                     |_|'
echo ' -- Backup your macOS Application icons before it is too late...'
echo -e ${NOCOLOR}

noicons=""
wd=$(pwd)

backup() {
  echo -e "${GREEN}[+] Backing up $1${NOCOLOR}"
  for apps in $1/*; do
    apps=$(basename "$apps")
    if [[ "$apps" == *".app"* ]]; then
      appname=$(echo "$apps" | sed 's/.app//g')
      mkdir -p "$appname"
      cd "$1/$apps/Contents/Resources/"
      cp *.icns "$wd/$appname/"
      cd "$wd"
    else
      noicons="$apps, $noicons"
    fi
  done
}

backup "/Applications"
backup "/System/Applications"
backup "/Applications/Utilities"

if [ "$noicons" != "" ]; then
  echo -e "${YELLOW}[+] No Icons were copied from the following applications:${NOCOLOR}"
  echo $noicons
  echo -e "${YELLOW}[+] Consider backing up the icons of these applications manually.${NOCOLOR}"
fi
