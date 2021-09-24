##
# env. setup for OS X
#

# env. variables ------------------------------------------------------------

# for the occasional X11 app
export DISPLAY=:0.0

export JAVA_HOME="$(/usr/libexec/java_home -v 1.7 2>/dev/null)"

export PATH="${HOME}/bin:${PATH}"
# extend the PATH
export PATH=".bundle/binstubs:${PATH}"
export PATH="${NPM_ROOT}/bin:${PATH}"

# aliases -------------------------------------------------------------------

alias df='df -T hfs'
alias edit='mate'
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

function notify() {
  local TN_OPTS=()

  local MESSAGE=""
  local TITLE=""
  local SUBTITLE=""

  function _parse_options() {
    local OPTIND=0

    while getopts ":s:t:" opt; do
      case $opt in
        s) SUBTITLE="$OPTARG";;
        t) TITLE="$OPTARG";;
      esac
    done

    shift $((OPTIND - 1))

    MESSAGE="$1"
  }

  function _set_tn_opt() {
    TN_OPTS=( "${TN_OPTS[@]}" "-${1}" "${2}" )
  }

  _parse_options "$@"

  _set_tn_opt message "$MESSAGE"

  [[ "$SUBITTLE" == "" ]] || _set_tn_opt title "$TITLE"
  [[ "$TITLE" == "" ]]    || _set_tn_opt subtitle "$SUBTITLE"

  terminal-notifier "${TN_OPTS[@]}"
}
