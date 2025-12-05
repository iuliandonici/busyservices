#!/bin/bash
var_install_transmission_requirements=("transmission-cli" "transmission-common" "transmission-daemon")
function f_install_transmission_requirements() {
    source functions/f_update_software.sh
    source functions/f_config_transmission.sh
    f_update_software
    echo "- List of base software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_transmission_requirements[@]}"
    do
        echo " $i ${var_install_transmission_requirements[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo "- Currently installing: $i ${var_install_transmission_requirements[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) add ${var_install_transmission_requirements[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_transmission_requirements[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo "- Currently installing: $i ${var_install_transmission_requirements[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            fi
        done        
    else
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo "- Currently installing: $i ${var_install_transmission_requirements[$i]}"
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
