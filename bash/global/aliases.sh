##
# global.sh
#
# aliases, functions, etc. which should be set on every host
#

# aliases --------------------------------------------------------------

alias ..='cd ..'
alias beep='echo -ne "\a"'
alias body='curl -s'
alias epoch='date +%s'
alias grep='grep --color=auto'
alias freq='sort | uniq -c | graph'
alias get='curl -s -D -'
alias graph='awk '"'"'!max{max=$1;}{r="";i=s=60*$1/max;while(i-->0)r=r"#";printf "%15s %5d %s %s",$2,$1,r,"\n";}'"'"
alias headers='get -o /dev/null'
alias ip='wgetd http://checkip.amazonaws.com'
alias less='less -RciM'
alias ls='ls --color'
alias l='ls -hF'
alias ll='l -o'
alias llg='l -l'
alias natsort='php -r "\$a = file(\"php://stdin\"); natsort(\$a); print join(\$a);"'
alias now='date +"%F %H:%M %z"'
alias realpath='readlink -f'
alias rcp='rsync -avP'
alias rmv='rcp --remove-source-files'
alias shell='repl'
alias sum="tr ' ' \"\n\" | paste -s -d + - | bc"
alias stripansi='perl -ple "s/\033\[(?:\d*(?:;\d+)*)*m//g;"'
alias toupper='tr [:lower:] [:upper:]'
alias tolower='tr [:upper:] [:lower:]'
alias urlencode='perl -MURI::Escape -ne "\$/=\"\"; print uri_escape \$_"'
alias urldecode='perl -MURI::Escape -ne "\$/=\"\"; print uri_unescape \$_"'
alias wgetd='wget -O - --quiet'

# fix typos
alias snv='svn'

# functions ------------------------------------------------------------

##
# convert a user-friendly string into an ansi color or style code
#
function _ansi() {
  case "$1" in
    black)   echo 30;;
    red)     echo 31;;
    green)   echo 32;;
    yellow)  echo 33;;
    blue)    echo 34;;
    magenta) echo 35;;
    cyan)    echo 36;;
    white)   echo 37;;

    off)           echo 0;;
    bold)          echo 1;;
    faint)         echo 2;;
    italic)        echo 3;;
    underline)     echo 4;;
    blink)         echo 5;;
    fastblink)     echo 6;;
    reverse)       echo 7;;
    invisible)     echo 8;;
  esac;
}

##
# test whether a value exists in an array
#
# usage: COLORS=( red blue ); _in_array COLORS red && echo "found!"
#
function _in_array() {
  for ITEM in $(eval echo \${$1[*]}); do
    if [[ "$ITEM" = "$2" ]]; then return 0; fi
  done

  return 1;
}

##
# change base
#
# usage: cbase <base from> <base to> <value>
#
function cbase() {
  echo "obase=$2;ibase=$1;$3" | bc
}
# some shortcuts
alias bin2dec='cbase 2 10'
alias dec2bin='cbase 10 2'
alias dec2hex='cbase 10 16'
alias hex2dec='cbase 16 10'
alias hex2bin='cbase 16 2'
alias dec2oct='cbase 10 8'
alias oct2dec='cbase 10 8'

##
# user-friendly way to add ansi color to text
#
# usage:
#   echo i can print $(color red)red $(color off), \
#     $(color yellow green)yellow on green$(color off), or even \
#     $(color underline blue)underlined blue
#
# requires the _in_array and _ansi functions
#
function color() {
  local COLORS=( black red green yellow blue magenta cyan white );
  local EFFECTS=( normal bold faint italic underline blink fastblink reverse invisible doubleline );

  local codes=( )

  ##
  # add a color code to the code sequence array
  #
  function _push() {
    local code=$(_ansi $1)

    if [[ "$2" == "background" ]] && (( $code >= 30 )) && (( $code < 40 )); then
      code=$(($code + 10))
    fi;

    codes=("${codes[@]}" $code);
    return 0;
  }

  ##
  # do!
  #

  # not enough params
  if [[ "$#" > 3 ]]; then
    echo "error"
    return 1;

  # special case resetting to default colors
  elif [[ "$1" == off || -z "$1" ]]; then
    _push "off"

  # collect the params as ansi codes
  else
    for param in $*; do
      # is it a color?
      _in_array COLORS $param && {
        if [[ "$FG" != true ]]; then
          local FG=true
          _push $param
        elif [[ "$BG" != true ]]; then
          local BG=true
          _push $param "background"
        fi
        continue;
      }

      # is it an effect?
      _in_array EFFECTS $param && {
        _push $param
        continue
      }

      # unrecognized param
      echo -e "$(color red)error:$(color off) \"$param\" is not recognized"
      return 0
    done
  fi

  # gather the colors/effects as a sequence of ansi codes
  local seq=${codes[*]}
  seq=${seq// /;}

  # print it
  echo -en '\033['${seq}m;
}

##
# geoip
#
function geoip() {
  IP="$1"

  if [ -z "$IP" ]; then
    IP=$(ip)
  fi

  body "http://www.datasciencetoolkit.org/ip2coordinates/${IP}" | json
}

##
# extract - archive extractor (found: http://dotfiles.org/~morax/.bashrc)
#
# usage: extract <file>
#
function extract() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar)            tar xvf "$1"  ;;
      *.tar.bz2|*.tbz2) tar xvjf "$1" ;;
      *.tar.gz|*.tgz)   tar zvxf "$1" ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar x "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

##
# execute a command N times
#
# usage: forn 10 echo "this is echo {}"
#
function forn() {
  local num=$1; shift;
  local command=$@

  for(( i=1; i<=$num; i++ )); do
    `${command//\{\}/$i}`
  done
}

##
# append a command to the bash history without executing it
#
# scenario: you've typed out a long command and realized you need to do
#   something else before running it.  ^a and prefix with "savecommand".
#
# usage:
#   $ savecommand echo foo
#   (do something else)
#   $ !echo

function savecommand() {
  history -d $(history 1 | awk '{print $1}')
  history -a
  echo "$@" >> "$HISTFILE"
  history -r
}

##
# list hostnames of machines on which I have an account
#
# -p    return only personal hosts
# -w    return only work hosts
#
function hosts() {
  # hosts
  local h_personal="${HOSTS_PERSONAL[*]}"
  local h_work="${HOSTS_RUPTURE[*]}"

  # defaults
  local h_display=''
  local display_all=1;
  local display_personal='';
  local display_work='';

  # handle options
  OPTIND=
  while getopts "pw" option "$@"; do
    case "$option" in
       p ) display_all=''; display_personal=1;;
       w ) display_all=''; display_work=1;;
       ? ) echo "invalid option: $OPTARG"; return 1;;
    esac;
  done

  # print hostnames
  if [ -n "$display_all" ] || [ -n "$display_personal" ]; then
    h_display="$h_display $h_personal";
  fi
  if [ -n "$display_all" ] || [ -n "$display_work" ]; then
    h_display="$h_display $h_work";
  fi

  echo "$h_display" | trim | split
}

##
# convert a json array of objects to a list of some property's value
#
# usage:
#   $ echo '[{"some_prop":"foo"}, {"some_prop":"bar"}]' | jsonmap some_prop;
#   foo
#   bar
#
function jsonmap() {
  cat - | jq -r --arg prop "$1" 'map(.[$prop]) | .[]'
}

##
# test whether a domain is registered
#
# usage: echo foo bar | registered
# usage: registered foo.com
#
function registered() {
  if [ -z "$1" ]; then INPUT=`cat -`; else INPUT="$1"; fi

  for DOMAIN in $INPUT; do
    if [[ `expr index "$DOMAIN" \.` == "0" ]]; then
      DOMAIN="$DOMAIN.com"
    fi

    echo -n "$DOMAIN is... "

    if [ -z "`whois "$DOMAIN" | grep -i "no match for"`" ]; then
      echo "taken."
    else
      echo "available!"
    fi
  done
}

##
# start or resume a screen session, optionally loading a session-specific
# configuration from ~/.screen/<sessionname>.screenrc
#
# usage: screen rupture
#
function screen() {
  local screenbin=$(which screen)
  local sessionname="$1"
  local sessionrc=~/.screen/"$sessionname".screenrc
  local args

  # if name looks like a switch, just call screen with provided args and quit
  if [[ $# == 0 ]] || [[ ${sessionname:0:1} == "-" ]]; then
    args=("${@}")
  else
    # try to reattach
    "$screenbin" -d -r "$sessionname" && exit

    # pass args as args to screen
    args=(-S "${@}")

    # if there's a custom config, use it
    if [[ -f "$sessionrc" ]]; then
      # if there's a .screenrc, load it before the session's rc
      if [[ -f ~/.screenrc ]]; then
        local tmprc=$(mktemp)
        cat ~/.screenrc > "$tmprc"; echo >> "$tmprc"
        cat "$sessionrc" >> "$tmprc"
        sessionrc="$tmprc"
      fi

      args+=(-c "$sessionrc")
    fi
  fi

  # start screen
  "$screenbin" "${args[@]}"
}

##
# split a string into lines
# default split token: space
#
# usage: echo "this/is/a/string" | split "/"
#
function split() {
  echo `cat -` | tr "${1- }" "\n"
}

##
# trim a string, or each line in a string
#
# -l trim each line (default)
# -s trim the entire string
#
# usage: cat somefile.txt | trim
#
function trim() {
  INPUT=`cat -`

  # defaults
  t_each_line=''
  t_whole_string=''

  while getopts "ls" option "$@"; do
    case "$option" in
       l ) t_each_line=1;;
       s ) t_whole_string=1;;
       ? ) echo "invalid option: $OPTARG"; return 1;;
    esac;
  done

  if [ $t_whole_string ]; then
    INPUT=`echo "$INPUT" | \
           awk '
                       NF == 0 { nb++ ; next };
               nb      { for (i = 1; i <= NF; i++) print "" }
                       { nb = 0; print }' | \
           sed -En '1h; 1!H; $ {; g; s/^(\n|[ \t])*//; p; }'`
  fi

  if [ -z "$t_whole_string" ] || [ "$t_each_line" ]; then
    INPUT=`echo "$INPUT" | sed 's/^[ 	]*//;s/[ 	]*\$//'`
  fi

  echo "$INPUT"
}
