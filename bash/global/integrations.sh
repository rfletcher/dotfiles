##
# integrations.sh
#
# integrate third-party shell extensions
#

# fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# aws
which aws &>/dev/null && complete -C aws_completer aws

# hass-cli: https://github.com/home-assistant/home-assistant-cli
if which hass-cli &>/dev/null; then
  export HASS_SERVER="(not committed)"
  export HASS_TOKEN="(not committed)"

  eval "$(hass-cli completion bash)"
fi

# homebrew
export HOMEBREW_NO_ANALYTICS=1
if [[ -d /opt/homebrew ]]; then         # linux
  eval "$(/opt/homebrew/bin/brew shellenv | sed 's|/opt/homebrew|/home/linuxbrew/.linuxbrew|')"
elif [[ -x /usr/local/bin/brew ]]; then # macos
  eval "$(/usr/local/bin/brew shellenv)"
fi

# pipx: https://pypi.org/project/pipx
if which pipx &>/dev/null; then
  export PIPX_HOME=/usr/local/var/pipx
  export PIPX_BIN_DIR=/usr/local/bin
fi

# rbenv
if which rbenv &>/dev/null; then
  eval "$(rbenv init -)"
fi

# vig
which vig &>/dev/null && eval "$(vig init 2>&1)"
