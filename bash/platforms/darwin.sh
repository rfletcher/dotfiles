##
# env. setup for OS X
#

# env. variables ------------------------------------------------------------

# put /usr/local/bin in front so Homebrew-installed binaries take precidence
export PATH="/usr/local/bin:${PATH}"

# for the occasional X11 app
export DISPLAY=:0.0

export JAVA_HOME="$(/usr/libexec/java_home)"
export RBENV_ROOT=/usr/local/opt/rbenv

# aliases -------------------------------------------------------------------

alias edit='mate'
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
