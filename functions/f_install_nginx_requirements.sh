#!/bin/bash
var_install_nginx_requirements=("nginx")
function f_install_nginx_requirements() {
    source functions/f_update_software.sh
    source functions/f_config_nginx.sh
    f_update_software
    echo "- List of extra software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_nginx_requirements.sh[@]}"
    do
        echo " $i ${var_install_nginx_requirements.sh[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_nginx_requirements.sh[@]}"
        do
            echo "- Currently installing: $i ${var_install_nginx_requirements.sh[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) add ${var_install_nginx_requirements.sh[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_nginx_requirements.sh[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_nginx_requirements.sh[@]}"
        do
            echo "- Currently installing: $i ${var_install_nginx_requirements.sh[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_nginx_requirements.sh[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_nginx_requirements.sh[$i]}  
            fi
        done        
    else
        for i in "${!var_install_nginx_requirements.sh[@]}"
        do
            echo "- Currently installing: $i ${var_install_nginx_requirements.sh[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_nginx_requirements.sh[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_nginx_requirements.sh[$i]}  
            fi
        done
    fi
    f_update_software
    f_config_nginx
}