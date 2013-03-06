##
# env. settings for viglink machines
#

# env. variables -------------------------------------------------------

export VL_WORKSPACE=~/Code/viglink

# aliases --------------------------------------------------------------

alias cdv="cd $VL_WORKSPACE";

alias vl-build="pushd ${VL_WORKSPACE}/viglink-web && ant && ant app.compile && mvn install -Dmaven.test.skip=true && popd"
alias vl-build-all="pushd ${VL_WORKSPACE} && mvn install -Dmaven.test.skip=true && vl-build"
alias vl-clean="pushd ${VL_WORKSPACE} && mvn clean && pushd viglink-web && ant app.clean && mvn clean && popd && popd"
alias vl-reload="vl-build && tomcat-restart"
alias vl-reload-clean="vl-clean && vl-build-all && tomcat-restart"

# functions ------------------------------------------------------------
