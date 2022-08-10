#!/usr/bin/zsh
#        _                        _            ___  _  _   
#   __ _| | _____  _____ ___   __| | ___ _ __ / _ \| || |  
#  / _` | |/ _ \ \/ / __/ _ \ / _` |/ _ \ '__| | | | || |_ 
# | (_| | |  __/>  < (_| (_) | (_| |  __/ |  | |_| |__   _|
#  \__,_|_|\___/_/\_\___\___/ \__,_|\___|_|   \___/   |_|  
# 
# Copyright (c) 2021-2022 alexcoder04 <https://github.com/alexcoder04>
# 
# zsh profile

# start ssh-agent and select a bigger font at login in tty
case "$(tty)" in
  /dev/tty*)
    eval "$(ssh-agent)"
    setfont "ter-118n" ;;
esac

