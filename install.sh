#!/usr/bin/env bash

##
# link to .dotfiles/* from ~/
#

INSTALL_SCRIPT=$(basename "$BASH_SOURCE")
# get the real path to .dotfiles (`readlink -f` doesn't work in BSD)
DOTFILES_DIR=$(unset CDPATH && cd $(dirname "$BASH_SOURCE") && pwd -P)

function fatal {
  MSG="$1"
  echo "$MSG" >&2
  exit 1
}

# find files, ignoring hidden files and directories
find "$DOTFILES_DIR" -type f | sed "s#${DOTFILES_DIR}/##" | grep -vE "(^|/)\." | while read FILE; do
  DEST=$(dirname "$FILE")
  FILENAME=$(basename "$FILE")

  if [[ "$FILENAME" != "$INSTALL_SCRIPT" ]]; then
    if [[ "$DEST" != "." ]]; then
      mkdir -p ~/".${DEST}" || fatal "Couldn't make '$DEST'"
    fi

    # an old symlink in the way?
    [[ -L ~/".${FILE}" ]] && rm ~/".${FILE}"
    ln -s "${DOTFILES_DIR}/${FILE}" ~/".${FILE}" || fatal "Couldn't link '$FILE'"
  fi
done
