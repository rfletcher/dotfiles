##
# completions.sh
#
# initiate tab completions
#

if [[ -d /opt/homebrew/etc/bash_completion.d/ ]]; then
  for FILE in /opt/homebrew/etc/bash_completion.d/*; do
    . "$FILE"
  done
fi
