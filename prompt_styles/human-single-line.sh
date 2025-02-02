#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/config.sh
    . ~/.fancy-git/modules/update-manager.sh

    check_for_update
    
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

    # Colors
    local bold="\\[\\e[1m\\]"
    local bold_none="\\[\\e[0m\\]"
    local light_green="\\[\\e[92m\\]"
    local light_yellow="\\[\\e[93m\\]"
    local none="\\[\\e[39m\\]"
    local orange="\\033[95;38;5;214m"
    local light_magenta="\\[\\e[95m\\]"

    # Prompt
    local user="${orange}\u${none}"
    local host="${light_yellow}\h${none}"
    local where="${light_green}\w${none}"
    local venv=""
    local user_at_host=""
    local prompt_time=""

    if ! fancygit_config_is "show-full-path" "true"
    then
        where="${light_green}\W${none}"
    fi

    if ! [ -z ${VIRTUAL_ENV} ]; then
        venv="${light_yellow}`basename \"$VIRTUAL_ENV\"`${none} for "
    fi

    if ([ "$CONDA_DEFAULT_ENV" != "base" ] && ! [ -z ${CONDA_DEFAULT_ENV} ]); then
        venv="${light_yellow}`basename \"$CONDA_DEFAULT_ENV\"`${none} for "
    fi

    if [ "$branch_name" != "" ]; then
        branch_name=" on ${light_magenta}$branch_name${none}"
    fi

    if fancygit_config_is "show-time" "true"
    then
      formatted_time=$(date +"${time_format}")
      prompt_time="[${formatted_time}] "
    fi

    if fancygit_config_is "show-user-at-machine" "true"
    then
        user_at_host="${user} at ${host} in "
    fi

    PS1="${bold}${venv}${prompt_time}${user_at_host}$where$branch_name$(fg_branch_status 1) ${bold_none}\$ "
}

PROMPT_COMMAND="fancygit_prompt_builder"

