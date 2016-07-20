##
# env. settings for viglink machines
#

# env. variables -------------------------------------------------------

export VL_ROLE=rick
export VL_WORKSPACE=~/Code/viglink
# for `vig config`
export VIG_CONFIG="${VL_WORKSPACE}/viglink-config/viglink-hiera/src/main/resources/data/static.yaml"

# aliases --------------------------------------------------------------

alias cdv="cd ${VL_WORKSPACE}"
alias cdvc="cd ${VL_WORKSPACE}/viglink-config"
alias cdvh="cd ${VL_WORKSPACE}/viglink-config/viglink-hiera"
alias cdvj="cd ${VL_WORKSPACE}/viglink/viglink-javascript"
alias cdvp="cd ${VL_WORKSPACE}/viglink-config/viglink-puppet"
alias cdvr="cd ${VL_WORKSPACE}/viglink-rundeck"
alias cdvt="cd ${VL_WORKSPACE}/viglink-config/viglink-terraform"
alias cdvv="cd ${VL_WORKSPACE}/viglink-vagrant"

# functions ------------------------------------------------------------
