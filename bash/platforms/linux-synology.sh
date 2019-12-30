##
# env. setup for Synology
#

test -f /opt/etc/profile && . /opt/etc/profile

# env. variables ------------------------------------------------------------

export GIT_SSH="/usr/bin/ssh"
# put /usr/local/{s,}bin in front so opkg-installed binaries take precidence
export PATH="/opt/sbin:/opt/bin:${PATH}"

# aliases -------------------------------------------------------------------

# `ls` doesn't support -o
alias ll='l -l'
alias screen='TERM=xterm screen'

# functions -----------------------------------------------------------------
