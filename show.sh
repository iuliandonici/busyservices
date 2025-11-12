#!/bin/bash
source functions/f_install_gitea.sh
f_install_gitea
doas rm -rf /etc/gitea/app.ini
doas cp -r functions/f_config_gitea /etc/gitea/app.ini
