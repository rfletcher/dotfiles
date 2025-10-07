##
# integrations.sh
#
# integrate third-party extensions
#

# homebrew
if which brew &>/dev/null; then
  eval "$(brew shellenv 2>/dev/null)"
fi

if [ "$PS1" ]; then
  # aws
  which aws &>/dev/null && complete -C aws_completer aws

  # fzf: https://github.com/junegunn/fzf
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

# cli-privacy
if which cli-privacy &>/dev/null; then
  source $(which cli-privacy)
fi

# golang
export GOPATH="${HOME}/.go"

# krew
if which kubectl-krew &>/dev/null; then
  export PATH="${PATH}:${HOME}/.krew/bin"
fi

# pyenv
if which pyenv &>/dev/null; then
  eval "$(pyenv init - bash)"
fi

# rbenv
if which rbenv &>/dev/null; then
  eval "$(rbenv init - --no-rehash bash)"
fi
