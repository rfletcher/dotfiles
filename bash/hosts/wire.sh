##
# env. setup for air
#

# env. variables ------------------------------------------------------------

export TOMCAT_HOME=/usr/local/opt/tomcat6

# aliases -------------------------------------------------------------------

alias cdl="cd ~/Code/lineup"
alias tomcat-reset-logs="rm -rf \"${TOMCAT_HOME}\"/libexec/logs/*"
alias tomcat-clean="rm -rf \"${TOMCAT_HOME}\"/libexec/webapps/ROOT"
alias tomcat-start="JAVA_OPTS='-Xmx2048m -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled -XX:MaxPermSize=128M' startup.sh"
alias tomcat-restart="tomcat-stop && tomcat-reset-logs && tomcat-clean && tomcat-start"

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
