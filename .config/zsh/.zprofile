#!/usr/bin/zsh
#        _                        _            ___  _  _   
#   __ _| | _____  _____ ___   __| | ___ _ __ / _ \| || |  
#  / _` | |/ _ \ \/ / __/ _ \ / _` |/ _ \ '__| | | | || |_ 
# | (_| | |  __/>  < (_| (_) | (_| |  __/ |  | |_| |__   _|
#  \__,_|_|\___/_/\_\___\___/ \__,_|\___|_|   \___/   |_|  
# 
# Copyright (c) 2021-2023 alexcoder04 <https://github.com/alexcoder04>
# 
# zsh profile

# start ssh-agent and set a bigger font at login in tty
# do updates when on power and start gui session in tty1

_startup_default_tty() {
  eval "$(ssh-agent)"
  setfont "ter-118n"
}

case "$(tty)" in
  /dev/tty1)
    _startup_default_tty

    source "$ZDOTDIR/functions.zsh"
    if ! [ "$(cat "/sys/class/power_supply/BAT1/status")" = "Discharging" ]; then
      yesno "Do system update [y/n]? " && sudo pacman -Syu
    fi
    yesno "Start KDE Plasma [y/n]? " && sp
    ;;
  /dev/tty*)
    _startup_default_tty
    ;;
esac

