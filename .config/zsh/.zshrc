#!/usr/bin/zsh
#        _                        _            ___  _  _
#   __ _| | _____  _____ ___   __| | ___ _ __ / _ \| || |
#  / _` | |/ _ \ \/ / __/ _ \ / _` |/ _ \ '__| | | | || |_
# | (_| | |  __/>  < (_| (_) | (_| |  __/ |  | |_| |__   _|
#  \__,_|_|\___/_/\_\___\___/ \__,_|\___|_|   \___/   |_|
#
# Copyright (c) 2021-2022 alexcoder04 <https://github.com/alexcoder04>
#      
# zsh config

# CHECK IF RUNNING IN INTERACTIVE MODE
[[ -o interactive ]] || exit

# import other files {{{
source "$ZDOTDIR/abbreviations.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/bookmarks.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/cursor-prompt.zsh"

[ -f "$XDG_CONFIG_HOME/sh/colors.sh" ] && source "$XDG_CONFIG_HOME/colors.sh"
# }}}

# history configuration {{{
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
HISTORY_IGNORE="(git add *|git commit *|* _bookmark-ls|mpv http*)"
HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
HISTSIZE=15000
SAVEHIST=15000
# }}}

# autocompletion {{{
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# }}}

# keybindings {{{
KEYTIMEOUT=2
bindkey -v # vi mode

# vi navigation in menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# edit command in editor
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line

bindkey -s '^f' 'lfcd\n' # select folder to open with lf
bindkey -s '^o' 'fzfcd\n' # select folder to open with fzf
bindkey -s '^b' ' &>/dev/null & disown' # run command in the background
# }}}

# syntax highlighting {{{
if command -v pacman >/dev/null; then
  _zsh_syntax="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
  _zsh_syntax="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
[ -f "$_zsh_syntax" ] && source "$_zsh_syntax"
unset _zsh_syntax
# }}}

# other settings {{{
setopt autocd
unsetopt beep extendedglob notify
precmd_functions+=(_default_cursor)
setopt interactivecomments
ZSH_HIGHLIGHT_STYLES[comment]="fg=white,dim"
# }}}

# startup stuff if not inside lf
[ -z "$LF_LEVEL" ] && source "$ZDOTDIR/startup.zsh"

