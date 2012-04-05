##
# bash_profile: executed by bash for login shells
#
# I want login and non-login shells to be the same, so use bashrc for both
#

[ -f ~/.bashrc ] && . ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
