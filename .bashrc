#!/bin/bash
#        _                        _            ___  _  _   
#   __ _| | _____  _____ ___   __| | ___ _ __ / _ \| || |  
#  / _` | |/ _ \ \/ / __/ _ \ / _` |/ _ \ '__| | | | || |_ 
# | (_| | |  __/>  < (_| (_) | (_| |  __/ |  | |_| |__   _|
#  \__,_|_|\___/_/\_\___\___/ \__,_|\___|_|   \___/   |_|  
# 
# Copyright (c) 2021-2022 alexcoder04 <https://github.com/alexcoder04>
#                                                          
# .BASHRC

# -----------------------------------------------------------------------------
# ENVIROMENTAL VARIABLES
# -----------------------------------------------------------------------------
source "$HOME/.config/sh/env.sh" \
  || (echo "failed to load envoronmental variables!" && return)

# -----------------------------------------------------------------------------
# If not running interactively, don't do anything
# -----------------------------------------------------------------------------
case $- in
    *i*) ;;
      *) return;;
esac

# -----------------------------------------------------------------------------
# ALIASES, BOOKMARKS, COLORS
# -----------------------------------------------------------------------------
source "$XDG_CONFIG_HOME/sh/theme.sh"
[ -f "$XDG_CONFIG_HOME/bash/aliases.bash" ] && source "$XDG_CONFIG_HOME/bash/aliases.bash"
[ -f "$XDG_CONFIG_HOME/bash/bookmarks.bash" ] && source "$XDG_CONFIG_HOME/bash/bookmarks.bash"
[ -f "$XDG_CONFIG_HOME/sh/colors.sh" ] && source "$XDG_CONFIG_HOME/sh/colors.sh"

# -----------------------------------------------------------------------------
# HISTORY OPTIONS
# -----------------------------------------------------------------------------
HISTCONTROL=ignoreboth
HISTFILE=$XDG_CACHE_HOME/bash_history
HISTSIZE=10000
HISTFILESIZE=10000
shopt -s histappend

# -----------------------------------------------------------------------------
# SHOPTS
# -----------------------------------------------------------------------------
shopt -s autocd
shopt -s cdspell
shopt -s expand_aliases
shopt -s checkwinsize
bind "set completion-ignore-case on"

# -----------------------------------------------------------------------------
# PROMPT
# -----------------------------------------------------------------------------
PS1='[ \[\e[01;36m\]\u\[\e[00;34m\]@\[\e[01;32m\]\h\[\e[00m\] in \[\e[01;34m\]\w \[\e[00m\]]\[\e[01;36m\] \$\n \[\e[01;34m\]>\[\e[01;36m\]>\[\e[01;32m\]>\[\e[00m\] '
PS2=">> "

# -----------------------------------------------------------------------------
# STUFF SHOWN ON STARTUP
# -----------------------------------------------------------------------------
[ -z "$MACHINE_STARTUP" ] || eval "$MACHINE_STARTUP"
echo -e "\033[01;32mWelcome back to the Bourne-Again-Shell, $USER! :D \n \033[00m"

