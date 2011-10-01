##
# env. setup for jehu
#

# env. variables -------------------------------------------------------

# # include xalan
# export CLASSPATH="$CLASSPATH:/opt/local/var/macports/software/xalanj/2.7.0_1/opt/local/share/java/xalan.jar"
# # include xerces XML parser
# export CLASSPATH="$CLASSPATH:/opt/local/var/macports/software/xercesj/2.9.1_0/opt/local/share/java/xml-apis.jar:/opt/local/var/macports/software/xercesj/2.9.1_0/opt/local/share/java/xercesImpl.jar"

# aliases --------------------------------------------------------------

alias mvies='cd ~/Movies;
  for FILE in *.mkv; do rsync -avz --progress --remove-source-files "$FILE" pavement:/storage/media/video/Movies/Compressed/Full\\\ Size/; done;
  for FILE in *.avi; do rsync -avz --progress --remove-source-files "$FILE" pavement:/storage/media/video/Movies/Compressed/Downloaded/; done;'
alias yuicompressor='java -jar ~/bin/yuicompressor-2.4.2.jar'
# alias xalan='java org.apache.xalan.xslt.Process'

# functions ------------------------------------------------------------

function proxy() {
    PID=`ps aux | grep "ssh -D8080" | grep -v grep | awk '{ print $2; }'`

    if [ -n "$PID" ]; then
        kill $PID
    fi

    launchctl start org.openssh.dynamic-proxy
}