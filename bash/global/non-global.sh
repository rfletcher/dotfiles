##
# non-global.sh
#
# initiate platform- or host-specific scripts
#

## gather some info about the system, used to determine which scripts to run

PLATFORM=$(uname -s | tolower)
HOSTNAME=$(uname -n | sed 's/\..*//' | tolower)
type lsb_release &> /dev/null && DISTRIBUTION=$(lsb_release -i | cut -f 2 | tolower)

## include any host-, platform-, or distribution-specific files

# host-specific
if [ -f ~/.bash/hosts/"$HOSTNAME".sh ]; then
  . ~/.bash/hosts/"$HOSTNAME".sh
fi

# platform-specific
if [ -f ~/.bash/platforms/"$PLATFORM".sh ]; then
  . ~/.bash/platforms/"$PLATFORM".sh
fi

# distribution-specific
if [[ "$DISTRIBUTION" != "" && -f ~/.bash/platforms/"$PLATFORM"-"$DISTRIBUTION".sh ]]; then
  . ~/.bash/platforms/"$PLATFORM"-"$DISTRIBUTION".sh
fi

## run per-category scripts based on hostname

if [[ "$HOST_CATEGORIES" != "" ]]; then
  for CATEGORY in "${HOST_CATEGORIES[@]}"; do
    SCRIPT=".bash/categories/${CATEGORY}.sh"
    if [ -f ~/"${SCRIPT}" ]; then
      CATEGORY_ARR="HOSTS_$(echo $CATEGORY | toupper)[@]"
      for CATEGORY_HOST in "${!CATEGORY_ARR}"; do
        if [[ "$HOSTNAME" == "$CATEGORY_HOST" ]]; then
          . ~/"$SCRIPT"
        fi
      done
    fi
  done
fi
