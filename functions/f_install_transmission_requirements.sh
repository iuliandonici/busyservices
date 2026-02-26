#!/bin/bash
var_install_transmission=("transmission-cli" "transmission-common" "transmission-daemon")
var_install_transmission_alpine=("transmission-cli" "transmission-daemon")
var_install_transmission_debian=("transmission-cli" "transmission-common" "transmission-daemon")
function f_install_transmission() {
    source functions/f_update_software.sh
    source functions/f_config_transmission.sh
    f_update_software
    if [[ $(f_check_networks) == "UP" ]]; then
        if [[ $(f_get_distro_packager) == "apk" ]]; then
            echo "- List of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_transmission_alpine[@]}"
            do
                echo " $i ${var_install_transmission_alpine[$i]}"
            done
            for i in "${!var_install_transmission_alpine[@]}"
            do
                echo " - and currently installing: $i ${var_install_transmission_alpine[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) add ${var_install_transmission_alpine[$i]}  
                else
                    $(f_get_distro_packager) add ${var_install_transmission_alpine[$i]}  
                fi
            done     
        elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
            echo "- List of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_transmission_debian[@]}"
            do
                echo " $i ${var_install_transmission_debian[$i]}"
            done
            for i in "${!var_install_transmission_debian[@]}"
            do
                echo " - and currently installing: $i ${var_install_transmission_debian[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) install -y ${var_install_transmission_debian[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_transmission_debian[$i]}  
                fi
            done         
        elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
            echo "- List of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_transmission[@]}"
            do
                echo " $i ${var_install_transmission[$i]}"
            done
            for i in "${!var_install_transmission[@]}"
            do
                echo " - and currently installing: $i ${var_install_transmission[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) install -y ${var_install_transmission[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_transmission[$i]}  
                fi
            done         
        else
        echo "- List of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_transmission[@]}"
            do
                echo " $i ${var_install_transmission[$i]}"
            done
            for i in "${!var_install_transmission[@]}"
            do
                echo " - and currently installing: $i ${var_install_transmission[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) install -y ${var_install_transmission[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_transmission[$i]}  
                fi
            done         
        fi
        f_update_software
        f_config_transmission
    else
        echo "- but we can't install Transmission because the networks are DOWN;"
    fi
}
