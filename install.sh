#!/usr/bin/env bash

##
# link to all dotfiles from ~
#

READLINK_BIN="greadlink"

INSTALL_FILE=$(basename "$BASH_SOURCE")
DOTFILES_DIR=$(dirname "$($READLINK_BIN -f "$BASH_SOURCE")")

for FILE in "$DOTFILES_DIR"/*; do
  FILENAME=$(basename "$FILE")

  # if it's not the install script itself...
  if [[ "$FILENAME" != "$INSTALL_FILE" ]]; then
    # remove the old dotfile
    if [[ -f ~/".$FILENAME" ]] || [[ -L ~/".$FILENAME" ]]; then
      rm ~/".$FILENAME"
    fi

    # link to the dotfile
    if [[ -d "$FILE" ]]; then
      ln -s "$FILE" ~/".$FILENAME"
    else
      ln "$FILE" ~/".$FILENAME"
    fi
  fi
done
