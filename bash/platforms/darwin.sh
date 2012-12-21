##
# env. setup for OS X
#

# env. variables ------------------------------------------------------------

# put /usr/local/bin in front so Homebrew-installed binaries take precidence
export PATH="/usr/local/bin:${PATH}"

# for the occasional X11 app
export DISPLAY=:0.0

export RBENV_ROOT=/usr/local/opt/rbenv

# aliases -------------------------------------------------------------------

alias brew-upgrade='brew update && brew upgrade $(brew outdated | cut -d " " -f 1 | grep -v tomcat)'
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
