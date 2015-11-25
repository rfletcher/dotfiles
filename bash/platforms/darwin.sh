##
# env. setup for OS X
#

# env. variables ------------------------------------------------------------

# for the occasional X11 app
export DISPLAY=:0.0

export JAVA_HOME="$(/usr/libexec/java_home -v 1.7 2>/dev/null)"
export NPM_ROOT=/usr/local/share/npm
export RBENV_ROOT=/usr/local/var/rbenv
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# put /usr/local/{s,}bin in front so Homebrew-installed binaries take precidence
export PATH="/usr/local/bin:/usr/local/bin:${PATH}"
# extend the PATH
export PATH="${RBENV_ROOT}/shims:${NPM_ROOT}/bin:${PATH}"

# aliases -------------------------------------------------------------------

alias _='underscore'
alias edit='mate'
alias json='_ pretty'
alias mail='open "mailto:?body=$(cat - | stripansi | urlencode)"'
alias ql='qlmanage -p "$@" >& /dev/null'
alias sort='sort -k 1,1'
alias top='top -o cpu'
alias upgrade='brew update && brew upgrade --all'
# work around a vagrant bug: https://github.com/mitchellh/vagrant/issues/4930
alias vagrant-destroy-all='vagrant destroy $(vagrant status | grep vmware_fusion | grep -v "not created" | awk "{ print \$1 }")'

# coreutils (alias <cmd> to coreutils' g<cmd>)
alias expr='gexpr'
alias ls='gls --color'
alias readlink='greadlink'
alias seq='gseq'

# functions -----------------------------------------------------------------
