##
# platform-specific env. settings for OS X
#

# ENV variables --------------------------------------------------------

# for the occasional X11 app
export DISPLAY=:0.0

# aliases and functions ------------------------------------------------

alias ql='qlmanage -p "$@" >& /dev/null';
alias sort='sort -k 1,1'
alias top='top -o cpu'

# coreutils (alias <cmd> to coreutils' g<cmd>)
alias expr='gexpr'
alias ls='gls --color'
alias readlink='greadlink'
alias seq='gseq'
