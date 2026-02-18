#!/bin/bash
var_install_transmission_requirements=("transmission-cli" "transmission-common" "transmission-daemon")
var_install_transmission_requirements_alpine=("transmission-cli" "transmission-daemon")
var_install_transmission_requirements_debian=("transmission-cli" "transmission-common" "transmission-daemon")
function f_install_transmission_requirements() {
    source functions/f_update_software.sh
    source functions/f_config_transmission.sh
    f_update_software

    if [[ $(f_get_distro_packager) == "apk" ]]; then
        echo "- List of base software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_transmission_requirements_alpine[@]}"
        do
            echo " $i ${var_install_transmission_requirements_alpine[$i]}"
        done
        for i in "${!var_install_transmission_requirements_alpine[@]}"
        do
            echo " - and currently installing: $i ${var_install_transmission_requirements_alpine[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                doas $(f_get_distro_packager) add ${var_install_transmission_requirements_alpine[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_transmission_requirements_alpine[$i]}  
            fi
        done     
    elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        echo "- List of base software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_transmission_requirements_debian[@]}"
        do
            echo " $i ${var_install_transmission_requirements_debian[$i]}"
        done
        for i in "${!var_install_transmission_requirements_debian[@]}"
        do
            echo " - and currently installing: $i ${var_install_transmission_requirements_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_transmission_requirements_debian[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_transmission_requirements_debian[$i]}  
            fi
        done         
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        echo "- List of base software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo " $i ${var_install_transmission_requirements[$i]}"
        done
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo " - and currently installing: $i ${var_install_transmission_requirements[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            fi
        done         
    else
       echo "- List of base software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo " $i ${var_install_transmission_requirements[$i]}"
        done
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo " - and currently installing: $i ${var_install_transmission_requirements[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            fi
        done         
    fi
    f_update_software
    f_config_transmission
}
