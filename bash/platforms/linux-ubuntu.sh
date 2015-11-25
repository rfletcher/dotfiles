##
# env. setup for Ubuntu
#

# env. variables ------------------------------------------------------------

# aliases -------------------------------------------------------------------

alias js='smjs'
alias rsync='rsync --skip-compress=avi/mp3/mkv'
# fix backspace (found: http://ubuntuforums.org/showthread.php?t=90910)
alias screen='TERM=screen screen'
alias upgrade='echo "apt-get update && \
  apt-get -y upgrade && \
  apt-get -y dist-upgrade && \
  apt-get -y autoremove" | sudo bash'

# functions -----------------------------------------------------------------
