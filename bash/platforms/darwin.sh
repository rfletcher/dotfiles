##
# platform-specific env. settings for OS X
#

# ENV variables --------------------------------------------------------

# for the occasional X11 app
export DISPLAY=:0.0
# add macports binaries to the PATH
export PATH="~/bin:/opt/local/bin:/opt/local/sbin:$PATH"

# aliases and functions ------------------------------------------------

alias ql='qlmanage -p "$@" >& /dev/null';
alias sort='sort -k 1,1'
alias top='top -o cpu'
