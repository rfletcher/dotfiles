##
# env. settings for rupture machines
#
# see $HOSTS_PERSONAL in bashrc.sh
#

# env. variables -------------------------------------------------------

export RUPTURE_WORKSPACE=~/Documents/Code/rupture/website

# aliases --------------------------------------------------------------

alias rcd="cd $RUPTURE_WORKSPACE";

# functions ------------------------------------------------------------

##
# update from git
#
function rupdate() {
  local oldbranch=`__git_ps1 %s`

  rcd &&
  git checkout master &&
  git pull &&
  git submodule update &&
  rake db:migrate &&
  git checkout db/schema.rb &&
  git checkout $oldbranch &&
  git rebase master &&
  cd -
}

##
# create a rupture app development screen env., or reattach to the existing one
#
function rscreen() {
  screenrc=~/.screen/rupture.screenrc
  tmp=$(mktemp)

  # make sure the file is empty
  > "$tmp"

  # try to reattach to an existing rupture screen session
  screen -d -r rupture -c "$screenrc"
  # >/dev/null

  # if we couldn't reattach, set up the screen session
  if [[ "$?" != 0 ]]; then
    # define each window
    screens=(
      'Bash             = rcd; clear'
      'MySQL            = mysql5 -u root rupture_development'
      'Ruby on Rails    = rcd && rupdate && tail -f log/development.log'
      'Rupture Platform = rcd && cd ../platform && git pull && make && make test && make dev'
    )
    DEFAULT_SCREEN=1

    # create the screens
    OLDIFS="$IFS"
    for i in $(gseq 0 $((${#screens[@]} - 1))); do
      IFS="="; arr=( ${screens[$i]} ); IFS="$OLDIFS"

      screen_title=$(echo ${arr[0]} | trim)
      screen_command=$(echo ${arr[1]} | trim)

      # create the window
      echo screen >>"$tmp"
      # set the title
      if [ -n "$screen_title" ]; then
        echo title "'"$screen_title"'" >>"$tmp"
      fi
      # execute the shell command
      if [ -n "$screen_command" ]; then
        echo stuff "'"$screen_command"'" >>"$tmp"
        echo stuff '"\012"' >>"$tmp"
      fi
    done

    cat "$screenrc" >>"$tmp"

    # start a new rupture screen session
    screen -S rupture -c "$tmp"
  fi
}