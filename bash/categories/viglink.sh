##
# env. settings for viglink machines
#

# env. variables -------------------------------------------------------

export VL_ROLE=rick
export VL_WORKSPACE=~/Code/viglink

# aliases --------------------------------------------------------------

alias cdv="cd ${VL_WORKSPACE}";
alias cdvj="cdv && cd viglink-javascript";
alias cdvr="cdv && cd viglink-rails/src/main/rails";
alias cdvw="cdv && cd viglink-web";

alias mvn-install="mvn install -Dmaven.test.skip=true -DskipTests"

alias vl-clean="pushd ${VL_WORKSPACE} && mvn clean && popd"
alias vl-reload-clean="vl-clean && vl-reload"

# functions ------------------------------------------------------------

function vl-build() {
    local MODULE="$1"
    local CLEAN="${2:-0}"

    cdv

    if [[ "$MODULE" != "" ]]; then
        pushd "viglink-${MODULE}"
    fi

    if [[ "$CLEAN" == "1" ]]; then
        mvn clean
    fi

    mvn install -DskipTests
    local RESULT=$?

    if [[ "$MODULE" != "" ]]; then
        popd
    fi

    return $RESULT
}

function vl-reload() {
    vl-build core &&
    vl-build utils &&
    vl-build common &&
    vl-build hadoop &&
    vl-build domain &&
    vl-build web &&
    tomcat-restart

    return $?
}
