#!/usr/bin/env bash

##
# link to all dotfiles from ~
#

INSTALL_FILE=$(basename "$BASH_SOURCE")
DOTFILES_DIR=$(dirname "$(readlink -f "$BASH_SOURCE")")

for FILE in "$DOTFILES_DIR"/*; do
  FILENAME=$(basename "$FILE")

  # if it's not the install script itself...
  if [[ "$FILENAME" != "$INSTALL_FILE" ]]; then
    # remove the old dotfile
    if [[ -f ~/".$FILENAME" ]] || [[ -L ~/".$FILENAME" ]]; then
      rm ~/".$FILENAME"
    fi
    # link to the dotfile
    ln -s "$FILE" ~/".$FILENAME"
  fi
done
