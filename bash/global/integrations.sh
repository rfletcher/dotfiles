##
# integrations.sh
#
# integrate third-party shell extensions
#

# fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# aws
which aws &>/dev/null && complete -C aws_completer aws

# homebrew
export HOMEBREW_NO_ANALYTICS=1
if which brew &>/dev/null; then
  if [[ -d /opt/homebrew ]]; then
    eval "$(brew shellenv | sed 's|/opt/homebrew|/home/linuxbrew/.linuxbrew|')"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(brew shellenv)"
  fi
fi

# rbenv
which rbenv &>/dev/null && eval "$(rbenv init -)"

# vig
which vig &>/dev/null && eval "$(vig init 2>&1)"
