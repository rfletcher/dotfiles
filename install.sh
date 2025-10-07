#!/usr/bin/env bash

##
# link to .dotfiles/* from ~/
#

FORCE=
INSTALL_SCRIPT=$(basename "$BASH_SOURCE")
# get the real path to .dotfiles (`readlink -f` doesn't work on some systems)
DOTFILES_DIR=$(unset CDPATH && cd $(dirname "$BASH_SOURCE") && pwd -P)

function die() {
  echo "$1" >&2;
  exit 1
}

if [[ "$1" == "--force" ]]; then
  FORCE=1
fi

# find files, ignoring hidden files and directories
cd "${DOTFILES_DIR}/files"
find . -type f | sed "s|^./||" | while read -r FILE; do
  DEST=$(dirname "$FILE")
  FILENAME=$(basename "$FILE")

  if [[ "$DEST" != "." ]]; then
    mkdir -p ~/".${DEST}" || die "Couldn't make '$DEST'"
  fi

  # an old symlink in the way?
  if test -e ~/".${FILE}"; then
    if [[ "$FORCE" == "1" ]] || [[ -L ~/".${FILE}" ]]; then
      rm ~/".${FILE}"
    fi
  fi
  ln -s "${DOTFILES_DIR}/files/${FILE}" ~/".${FILE}" || die "Couldn't link '$FILE'"
done

cd "$DOTFILES_DIR"
find patches -name "*.patch" | while read -r PATCH; do
  git apply "$PATCH"
done
