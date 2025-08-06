#!/bin/bash
source functions/f_config_docker.sh
source functions/f_add_repo_docker.sh
# source functions/f_install_base_software.sh
# source functions/f_install_extra_software.sh
f_add_repo_docker
f_config_docker