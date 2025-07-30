#!/bin/bash
git config --global user.email "iuliandonici@gmail.com"
git config --global user.name "Iulian Donici"
# 6. Config that every pull is being rebased
git config --global pull.rebase true
# 7. Make differences more visible
git config --global diff.colorMoved zebra
# 8. Prune on fetch: clean Git objects in your repository locally whenever you fetch changes from remote.
# (https://spin.atomicobject.com/2020/05/05/git-configurations-default/)
git config --global fetch.prune true