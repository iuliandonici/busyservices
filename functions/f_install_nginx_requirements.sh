#!/bin/bash
function f_install_nginx_requirements() {
    var_install_nginx_requirements=("nginx")
    source functions/f_get_distro_packager.sh
    source functions/f_update_software.sh
    source functions/f_check_networks.sh
    source functions/f_config_nginx.sh
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ $(f_check_networks) == "UP" ]]; then
            echo "- here's a list of software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_nginx_requirements[@]}"
            do
                echo " $i ${var_install_nginx_requirements[$i]}"
            done
            f_update_software
            for i in "${!var_install_nginx_requirements[@]}"
            do
                echo "- and currently installing: $i ${var_install_nginx_requirements[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) add ${var_install_nginx_requirements[$i]}  
                else
                    $(f_get_distro_packager) add ${var_install_nginx_requirements[$i]}  
                fi
            done
        else
            echo "- but can't install them because the networks are down;"
        fi
        f_config_nginx
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        if [[ $(f_check_networks) == "UP" ]]; then
            echo "- here's a list of software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_nginx_requirements[@]}"
            do
                echo " $i ${var_install_nginx_requirements[$i]}"
            done
            f_update_software
            for i in "${!var_install_nginx_requirements[@]}"
            do
                echo "- and currently installing: $i ${var_install_nginx_requirements[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) install -y ${var_install_nginx_requirements[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_nginx_requirements[$i]}  
                fi
            done
        else
            echo "- but can't install them because the networks are down;"
        fi
        f_config_nginx
    else
        if [[ $(f_check_networks) == "UP" ]]; then
            echo "- here's a list of software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_nginx_requirements[@]}"
            do
                echo " $i ${var_install_nginx_requirements[$i]}"
            done
            f_update_software
            for i in "${!var_install_nginx_requirements[@]}"
            do
                echo "- and currently installing: $i ${var_install_nginx_requirements[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) install -y ${var_install_nginx_requirements[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_nginx_requirements[$i]}  
                fi
            done
        else
            echo "- but can't install them because the networks are down;"
        fi
        f_config_nginx  
    fi
}
