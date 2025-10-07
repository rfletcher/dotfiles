#!/usr/bin/env bash

##
# link to .dotfiles/* from ~/
#

INSTALL_SCRIPT=$(basename "$BASH_SOURCE")
# get the real path to .dotfiles (`readlink -f` doesn't work on some systems)
DOTFILES_DIR=$(unset CDPATH && cd $(dirname "$BASH_SOURCE") && pwd -P)

function die() {
  echo "$1" >&2;
  exit 1
}

# find files, ignoring hidden files and directories
cd "${DOTFILES_DIR}/files"
find . -type f | sed "s|^./||" | while read -r FILE; do
  DEST=$(dirname "$FILE")
  FILENAME=$(basename "$FILE")

  if [[ "$DEST" != "." ]]; then
    mkdir -p ~/".${DEST}" || die "Couldn't make '$DEST'"
  fi

  # an old symlink in the way?
  [[ -L ~/".${FILE}" ]] && rm ~/".${FILE}"
  ln -s "${DOTFILES_DIR}/files/${FILE}" ~/".${FILE}" || die "Couldn't link '$FILE'"
done
