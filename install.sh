#!/usr/bin/env bash

##
# link to .dotfiles/* from ~/
#

INSTALL_SCRIPT=$(basename "$BASH_SOURCE")
# get the real path to .dotfiles (`readlink -f` doesn't work in BSD)
DOTFILES_DIR=$(unset CDPATH && cd $(dirname "$BASH_SOURCE") && pwd -P)

for FILE in "$DOTFILES_DIR"/*; do
  FILENAME=$(basename "$FILE")

  # if it's not the install script itself...
  if [[ "$FILENAME" != "$INSTALL_SCRIPT" ]]; then
    # complain about non-symlinks that are in the way
    if [ -e ~/".$FILENAME" ] && [ ! -L ~/".$FILENAME" ]; then
      echo "error: $FILENAME is in the way" >&2
    else
      rm "$FILENAME" && ln -s "$FILE" ~/".$FILENAME"
    fi
  fi
done
