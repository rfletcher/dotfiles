##
# env. setup for blur
#

# category env setup
. ~/.bash/non-global/categories/personal.sh

##
# environmental variables
#

##
# aliases and functions
#

function plex-update() {
    if [[ "$1" == "music" || "$1" == "video" ]]; then
        curl --get "http://localhost:3000/xbmcCmds/xbmcHttp?command=ExecBuiltIn&parameter=XBMC.updatelibrary($1)" >/dev/null 2>&1
        return $?
    elif [[ "$1" == "" ]]; then
        plex-update video && plex-update music
        return $?
    else
        return 1
    fi
}