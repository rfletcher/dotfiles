##
# env. settings for rupture machines
#

# env. variables ------------------------------------------------------------

export RUPTURE_WORKSPACE=~/Documents/Code/rupture/website

# aliases -------------------------------------------------------------------

alias rcd="cd $RUPTURE_WORKSPACE";
alias rscreen="screen rupture";

# functions -----------------------------------------------------------------

##
# update from git
#
function rupdate() {
  rcd
  local oldbranch=`__git_ps1 %s`

  ( test "$oldbranch" = "master" || git checkout master ) &&
  git pull &&
  git submodule update --init &&
  rake db:migrate &&
  rake platform:update &&
  git checkout db/schema.rb &&
  ( test "$oldbranch" = "master" || git checkout $oldbranch ) &&
  rake platform:start
  cd -
}
