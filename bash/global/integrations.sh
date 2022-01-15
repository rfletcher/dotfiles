##
# integrations.sh
#
# integrate third-party shell extensions
#

# homebrew
if which brew &>/dev/null; then
  eval "$(brew shellenv 2>/dev/null)"

  # export NODE_PATH="$(brew --prefix)/lib/node_modules"
  # export NPM_ROOT="$NODE_PATH"

  # if [[ -d /opt/homebrew ]]; then         # linux
  #   eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null | sed 's|/opt/homebrew|/home/linuxbrew/.linuxbrew|')"
  # elif [[ -x /usr/local/bin/brew ]]; then # macos
  #   eval "$(/usr/local/bin/brew shellenv 2>/dev/null)"
  # fi
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

if which kubectl-krew &>/dev/null; then
  export PATH="${PATH}:${HOME}/.krew/bin"
fi

# # pipx: https://pypi.org/project/pipx
# if which pipx &>/dev/null; then
#   export PIPX_HOME=/usr/local/var/pipx
#   export PIPX_BIN_DIR=/usr/local/bin
# fi

# rbenv
if which rbenv &>/dev/null; then
  eval "$(rbenv init -)"
fi
