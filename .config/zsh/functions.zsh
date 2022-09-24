#!/usr/bin/zsh
#        _                        _            ___  _  _
#   __ _| | _____  _____ ___   __| | ___ _ __ / _ \| || |
#  / _` | |/ _ \ \/ / __/ _ \ / _` |/ _ \ '__| | | | || |_
# | (_| | |  __/>  < (_| (_) | (_| |  __/ |  | |_| |__   _|
#  \__,_|_|\___/_/\_\___\___/ \__,_|\___|_|   \___/   |_|
#
# Copyright (c) 2021-2022 alexcoder04 <https://github.com/alexcoder04>
#      
# zsh functions

source libsh || echo "Warning: Failed to source libsh!"

# edit config files {{{
conf(){
  case "$1" in
    v) $EDITOR "$XDG_CONFIG_HOME/nvim/init.vim" ;;
    *) echo "$1 is not a valid argument" ;;
  esac
}
# }}}

# download image and show it {{{
show_image_url(){
  tempfile="${TMPDIR:-/tmp}/${1##*/}"
  wget -O "$tempfile" "$1" \
    && nsxiv "$tempfile" & disown
  unset tempfile
}
# }}}

# download and show some information that is hard to remember {{{
remember(){
  case "$1" in
    ascii) show_image_url "https://www.translationroyale.com/wp-content/uploads/2020/02/ASCII-Table-The-History-of-Unicode-and-Its-Role-in-the-Digital-World-Translation-Royale-1024x959.png" ;;
    raspi-pins) show_image_url "https://i1.wp.com/mbrobotics.es/blog/wp-content/uploads/2018/05/Raspberry-GPIO-Pins_B_plus.jpg" ;;
    latex-colors) show_image_url "https://sharelatex-wiki-cdn-671420.c.cdn77.org/learn-scripts/images/d/d3/ColoursEx6.png" ;;
    powerline) show_image_url "https://raw.githubusercontent.com/ryanoasis/powerline-extra-symbols/master/img/fontforge.png" ;;
    list | help | --help) echo "ascii, raspi-pins, latex-colors, powerline" ;;
    *) echo "invalid argument" ;;
  esac
}
# }}}

# search history {{{
hist(){
  selected="$(tac "$HISTFILE" | prompt "zsh: " | tr "\n" " ")"
  [ -z "$selected" ] && return
  echo -n "$selected" | clipboard_copy
  unset selected
}
# }}}

# mount a luks encrypted drive {{{
# use:
# `mount-luks /dev/sdX <mapper-name>` # /dev/sdX -> /media/<mapper-name>
mount-luks(){
  [ -z "$1" ] && exit 1
  if [ "$1" = "--help" ]; then
    echo "mount-luks /dev/sdX <name> # => /dev/sdX -> /media/<name>"
    return 0
  fi
  [ -z "$2" ] && exit 1
  doas cryptsetup open "$1" "$2" \
    && doas mount -v "/dev/mapper/$2" "/media/$2"
}
# }}}

# cd into folder selected using lf or fzf {{{
lfcd(){
  tmp="${TMPDIR:-/tmp}/.lfcd"
  lf -last-dir-path="$tmp" "$@"
  [ -f "$tmp" ] || return
  dir="$(cat "$tmp")"
  rm -f "$tmp"
  [ -d "$dir" ] && cd "$dir"
  unset tmp
  unset dir
}

fzfcd(){
  dest="$(cat "$DOTFILES_REPO/bookmarks/source-"* | awk '{print $2}' | sort | fzf)"
  [ -z "$dest" ] && return
  # maybe it's like $XDG_CONFIG_HOME
  dir="$(eval "echo $dest")"
  [ -d "$dir" ] && cd "$dir"
  unset dest
  unset dir
}
# }}}

