##
# env. settings for rupture machines
#
# see $HOSTS_PERSONAL in bashrc.sh
#

# env. variables -------------------------------------------------------

export RUPTURE_WORKSPACE=~/Documents/Code/rupture/website

# aliases --------------------------------------------------------------

alias rcd="cd $RUPTURE_WORKSPACE";
alias rscreen="screen rupture";

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
