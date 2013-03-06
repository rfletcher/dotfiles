##
# env. setup for air
#

# env. variables ------------------------------------------------------------

# aliases -------------------------------------------------------------------

alias cdl="cd ~/Code/lineup"
alias tomcat-start="JAVA_OPTS='-Xmx1024m' startup.sh"
alias tomcat-restart="tomcat-stop && tomcat-start"

# functions -----------------------------------------------------------------

function tomcat-stop() {
  shutdown.sh 2>/dev/null
  if [[ "$?" == 0 ]]; then
    PID=$(ps aux | grep -i [j]ava | grep -i Tomcat | awk '{ print $2; }')
    if [[ "$PID" != "" ]]; then
      kill -9 $PID
    fi
  fi
  return $?
}
