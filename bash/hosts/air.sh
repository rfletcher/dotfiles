##
# env. setup for air
#

# env. variables ------------------------------------------------------------

# aliases -------------------------------------------------------------------

alias cdb="cd ~/Code/baseballdb"
alias tomcat-start="startup.sh"
alias tomcat-restart="tomcat-stop && tomcat-start"

# functions -----------------------------------------------------------------

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
