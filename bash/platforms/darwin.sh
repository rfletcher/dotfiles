##
# env. setup for OS X
#

# env. variables ------------------------------------------------------------

# for the occasional X11 app
export DISPLAY=:0.0

# aliases -------------------------------------------------------------------

alias brew-upgrade='brew update && brew install $(brew list | grep -v tomcat)'
alias mail='open "mailto:?body=$(cat - | stripansi | urlencode)"'
alias ql='qlmanage -p "$@" >& /dev/null'
alias sort='sort -k 1,1'
alias top='top -o cpu'

# coreutils (alias <cmd> to coreutils' g<cmd>)
alias expr='gexpr'
alias ls='gls --color'
alias readlink='greadlink'
alias seq='gseq'

# functions -----------------------------------------------------------------
