#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018
#
# Changes de prompt by loading the style configured in ~/.fancygit/app_config file.

. "$HOME/.fancy-git/aliases"
. "$HOME/.fancy-git/fancygit-completion"
. "$HOME/.fancy-git/commands.sh"
. "$HOME/.fancy-git/modules/settings-manager.sh"
. "$HOME/.fancy-git/modules/git-manager.sh"
. "$HOME/.fancy-git/modules/update-manager.sh"
. "$HOME/.fancy-git/version.sh"

# ----------------------------------------------------------------------------------------------------------------------
# The main FanyGit function. It changes the prompt.
# ----------------------------------------------------------------------------------------------------------------------
function fancygit_prompt_changer() {
    local style

    style=$(fancygit_config_get "style" "default")

    case "$style" in
        "default"|"dark"|"dark-col"|"light"|"dracula")
            . ~/.fancy-git/prompt_styles/default.sh && return;;
    esac

    . ~/.fancy-git/prompt_styles/"${style}.sh"
}

fancygit_prompt_changer
