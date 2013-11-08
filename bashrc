##
# .bashrc
#

# standard ENV variables ----------------------------------------------------

export EDITOR=vi
# add ~/bin to the path, if it exists
[ -d ~/bin ] && export PATH="~/bin:${PATH}"

# other ENV variables -------------------------------------------------------

export HOST_CATEGORIES=( personal viglink )

export HOSTS_PERSONAL=( blur quicksand wire )
export HOSTS_VIGLINK=( wire )

# bash history --------------------------------------------------------------

export HISTCONTROL=ignoredups         # ignore repeated commands
export HISTIGNORE="$HISTIGNORE:ls:cd" # ignore specific commands
export HISTSIZE=10000                 # remember N commands in `history`
export HISTFILESIZE=${HISTSIZE}       # remember N commands across sessions

# bash options --------------------------------------------------------------

shopt -s cdspell        # correct minor spelling errors in a `cd` command
shopt -s cmdhist        # save multiline commands in history as one-liners
shopt -s extglob        # "extended" pattern globbing
shopt -s histappend     # append to history rather than overwrite
shopt -s expand_aliases # include aliases when tab-completing commands
shopt -s nocaseglob     # make path globbing case insensitive
shopt -s checkwinsize   # check window dimensions after each command

# extras --------------------------------------------------------------------

. ~/.bash/global/aliases.sh
. ~/.bash/global/non-global.sh

# interactive shell?
if [ "$PS1" ]; then
  if [[ -d /usr/local/etc/bash_completion.d/ ]]; then
    for FILE in /usr/local/etc/bash_completion.d/*; do
      . "$FILE"
    done
  fi

  . ~/.bash/global/colors.sh
  . ~/.bash/global/prompt.sh
fi
