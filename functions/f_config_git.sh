#!/bin/bash
function f_config_git() {
    if [[ -f /usr/bin/git ]]; then
        echo "- and git is installed; now we'll configure it;"
        git config --global user.email "iuliandonici@gmail.com"
        git config --global user.name "Iulian Donici"
        # 6. Config that every pull is being rebased
        git config --global pull.rebase true
        # 7. Make differences more visible
        git config --global diff.colorMoved zebra
        # 8. Prune on fetch: clean Git objects in your repository locally whenever you fetch changes from remote.
        # (https://spin.atomicobject.com/2020/05/05/git-configurations-default/)
        git config --global fetch.prune true
    else 
        echo "- but can't configure git because it's not installed:"
        ls -alh /usr/bin/ | grep "git"
    fi
}