##
# non-global.sh
#
# initiate platform- or host-specific scripts
#

## set some variables, used to determine which * scripts to run

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

# linux distribution-specific
if [[ "$DISTRIBUTION" != "" && -f ~/.bash/platforms/"$PLATFORM"-"$DISTRIBUTION".sh ]]; then
  . ~/.bash/platforms/"$PLATFORM"-"$DISTRIBUTION".sh
fi

## run per-category scripts based on hostname

