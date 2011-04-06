##
# env. setup for jehu
#

# category env setup (TODO: do this automatically based on hostname)
. ~/.bash/categories/personal.sh
. ~/.bash/categories/viglink.sh

# env. variables -------------------------------------------------------

# for Tomcat
# export JAVA_HOME=/Library/Java/Home
# export CATALINA_HOME=/Library/Tomcat/Home

# aliases --------------------------------------------------------------

alias cdb="cd ~/Code/baseballdb"
alias tomcat-start="startup.sh"
alias tomcat-restart="tomcat-stop && tomcat-start"
alias yuicompressor='java -jar ~/bin/yuicompressor-2.4.2.jar'
alias closurecompiler='java -jar ~/bin/compiler.jar'

# functions ------------------------------------------------------------

function tomcat-stop() {
  shutdown.sh 2>/dev/null
  if [[ "$?" == 0 ]]; then
    PID=$(ps | grep -i [j]ava | grep -i Tomcat | awk '{ print $1; }')
    if [[ "$PID" != "" ]]; then
      kill $PID
    fi
  fi
  return $?
}