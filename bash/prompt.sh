##
# prompt.sh
#
# custom bash prompt
#

# show git state in addition to the branch name
export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWSTASHSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

##
# set default prompt colors
#
C_NORMAL="off"

C_HOST="off"
C_COLON="off"
C_BRANCH="cyan"
C_END_CHAR="off"

C_DIR_OWNER="green"
C_DIR_WRITABLE="cyan"
C_DIR_NOWRITE="red"

# these are used in the pwd_color() function, so they have to be exported
export C_DIR_OWNER C_DIR_WRITABLE C_DIR_NOWRITE

##
# pwd color
#
# get the color code for the current directory
#
get_pwd_color() {
  if [ -O "$PWD" ]; then
    echo $C_DIR_OWNER
  elif [ -w "$PWD" ]; then
    echo $C_DIR_WRITABLE
  else
    echo $C_DIR_NOWRITE
  fi
}

##
# alter the prompt when running as root
#
if [[ "$EUID" == "0" ]]; then
  # ...add a red exclamation prefix
  PREFIX="\[$(color red)\]!\[$(color off)\]"
  # ...set the host color to red
  # C_HOST="red"
fi

##
# set the prompt
#
export PS1="\
${PREFIX}\
\[$(color ${C_HOST})\]\h\
\[$(color ${C_COLON})\]:\
\[\$(color \$(get_pwd_color))\]\w\
\[$(color ${C_BRANCH})\]\$(__git_ps1 ' %s')\
\[$(color ${C_END_CHAR})\]\$ \
\[$(color off)\]"
