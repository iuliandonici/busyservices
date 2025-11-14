#!/bin/bash
function f_install_server_dev_software() {
    source functions/f_install_nginx_requirements.sh
    f_install_nginx_requirements
}
f_install_server_dev_software
