##
# env. setup for OS X
#

# env. variables ------------------------------------------------------------

# put /usr/local/{s,}bin in front so Homebrew-installed binaries take precidence
export PATH="/usr/local/bin:/usr/local/bin:${PATH}"

# for the occasional X11 app
export DISPLAY=:0.0

export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH=".bundle/binstubs:/usr/local/share/npm/bin:$PATH"
export RBENV_ROOT=/usr/local/opt/rbenv

# aliases -------------------------------------------------------------------

alias _='underscore'
alias edit='mate'
alias json='_ pretty'
alias mail='open "mailto:?body=$(cat - | stripansi | urlencode)"'
alias ql='qlmanage -p "$@" >& /dev/null'
alias sort='sort -k 1,1'
alias top='top -o cpu'
alias upgrade='brew update && brew upgrade'

# coreutils (alias <cmd> to coreutils' g<cmd>)
alias expr='gexpr'
alias ls='gls --color'
alias readlink='greadlink'
alias seq='gseq'

# functions -----------------------------------------------------------------
