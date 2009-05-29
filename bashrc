##
# .bashrc
#

# standard ENV variables -----------------------------------------------

export EDITOR=vi

# other ENV variables --------------------------------------------------

export HOSTS_PERSONAL=( blur jehu pavement quicksand spoon )
export HOSTS_RUPTURE=( jehu dev.rupture.ea.com )

# bash history ---------------------------------------------------------

export HISTCONTROL=ignoredups         # ignore duplicate commands
export HISTIGNORE="$HISTIGNORE:ls:cd" # ignore specific commands
export HISTSIZE=10000                 # bash `history` will remember N commands
export HISTFILESIZE=${HISTSIZE}       # bash will remember N commands

# bash options ---------------------------------------------------------

shopt -s cdspell        # correct minor spelling errors in a `cd` command
shopt -s cmdhist        # save multiline commands in history as one-liners
shopt -s extglob        # "extended" pattern globbing
shopt -s histappend     # append to history rather than overwrite
shopt -s expand_aliases # include aliases when tab-completing commands
shopt -s nocaseglob     # make path globbing case insensitive
shopt -s checkwinsize   # check window dimensions after each command

# extras ---------------------------------------------------------------

. ~/.bash/aliases.sh
. ~/.bash/non-global.sh

if [ "$PS1" ]; then
  . ~/.bash/colors.sh
  . ~/.bash/completions/*.sh
  . ~/.bash/prompt.sh
fi
