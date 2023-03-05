#!/usr/bin/zsh
#        _                        _            ___  _  _
#   __ _| | _____  _____ ___   __| | ___ _ __ / _ \| || |
#  / _` | |/ _ \ \/ / __/ _ \ / _` |/ _ \ '__| | | | || |_
# | (_| | |  __/>  < (_| (_) | (_| |  __/ |  | |_| |__   _|
#  \__,_|_|\___/_/\_\___\___/ \__,_|\___|_|   \___/   |_|
#
# Copyright (c) 2022-2023 alexcoder04 <https://github.com/alexcoder04>
#      
# zsh prompt/cursor config

# helper functions {{{
_prompt_check_git(){
  [ -d ".git" ] || return
  echo "on %F{yellow}  $(git branch | grep -E "^\\* " | cut -d" " -f2)%f"
}

_prompt_check_chroot(){
  command -v ischroot >/dev/null || return
  ischroot && printf "[ %%F{blue}chroot%%f ] "
}

_prompt_check_lf(){
  [ ! -z "$LF_LEVEL" ] && printf "[ %%F{blue}lf$LF_LEVEL%%f ] "
}

_prompt_check_pwd() {
  echo "$PWD" | sed -E "s/^$(printf "%s" "$HOME" | sed -E "s/\\//\\\\\\//g")//"
}

_default_cursor() {
   echo -ne '\e[5 q'
}

# measure command execution time {{{
preexec(){
    _command_started="$(date +%s)"
}

_prompt_last_command_duration(){
    [ -z "$_command_started" ] && return
    local _command_duration="$(("$(date +%s)" - "$_command_started"))"
    [ "$_command_duration" -lt 3  ] && return
    printf "[ %%F{yellow}took %%B${_command_duration}s%%b%%f ] "
}
# }}}
# }}}

# Vi/Insert mode indicator {{{
# from http://pawelgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/
vim_ins_mode="%(?.%F{green} %f.%F{red}%?  %f)"
vim_cmd_mode="%F{blue}%f"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  # set cursor
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;;
    viins|main) echo -ne '\e[5 q' ;;
  esac

  # set prompt
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}
# }}}

# ACTUAL PROMPT
setopt prompt_subst
PROMPT='%F{blue}[%f %B%F{green}%n%b%F{red}@%F{yellow}%m%f %F{blue}]%f in %F{cyan}$(_prompt_check_pwd)%f $(_prompt_check_git)
$(_prompt_check_chroot)$(_prompt_check_lf)$(_prompt_last_command_duration)%1(j.%F{magenta} %j%f.) ${vim_mode} '

