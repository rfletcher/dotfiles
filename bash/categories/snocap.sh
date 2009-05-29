##
# env. settings for snocap machines
#

##
# environmental variables
#

# oracle env stuff
export ORACLE_HOME=/opt/oracle/product/10.1.0.3/instantclient
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export NLS_LANG=AMERICAN_AMERICA.UTF8
# snocap workspace path
export WORKSPACE=~/workspace/snocap

##
# aliases and functions
#

alias ws='workspace.php'

alias dev='cd `ws --print-dir --local`'
alias qa='cd `ws --print-dir -b qa --local`'
alias prod='cd `ws --print-dir -b prod --local`'

##
# "sideways" cd
#
# scd <branch>
#
function scd() {
  if [ -z "$1" ]; then
    echo "Usage: scd <branch>" >&2
    return 1;
  fi

  BRANCH=`ws --print-branch --local -b $1`

  NEW_DIR=`pwd | sed -r -e "s/(trunk|wa[0-9]+)/$BRANCH/"`

  if [ -d "$NEW_DIR" ] ; then
    cd "$NEW_DIR"
  else
    echo "Invalid dir: $NEW_DIR" >&2
    return 1;
  fi
  return 0;
}