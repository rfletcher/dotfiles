##
# integrations.sh
#
# integrate third-party shell extensions
#

# fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# aws
which aws &>/dev/null && complete -C aws_completer aws

# vig
which vig &>/dev/null && eval "$(vig init 2>&1)"