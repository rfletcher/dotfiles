##
# env. setup for OS X
#

# env. variables ------------------------------------------------------------

# for the occasional X11 app
export DISPLAY=:0.0

# aliases -------------------------------------------------------------------

alias mail='open "mailto:?body=$(cat - | stripansi | urlencode)"'
alias ql='qlmanage -p "$@" >& /dev/null'
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

    MESSAGE="$@"
  }

  function _set_tn_opt() {
    TN_OPTS=( "${TN_OPTS[@]}" "-${1}" "${2}" )
  }

  _parse_options "$@"

  _set_tn_opt message "$MESSAGE"

  [[ "$TITLE" == "" ]]    || _set_tn_opt title "$TITLE"
  [[ "$SUBTITLE" == "" ]] || _set_tn_opt subtitle "$SUBTITLE"

  set -x
  terminal-notifier "${TN_OPTS[@]}"
  set +x
}
