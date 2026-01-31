#!/bin/bash
# Not tested on Alpine
var_install_sonarr_software_array_alpine=("")
var_install_sonarr_software_array_debian=("")
var_install_sonarr_software_array=("")
function f_install_sonarr() {
    source functions/f_update_software.sh
    f_update_software
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        echo " - here's a list of extra software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_sonarr_software_array_alpine[@]}"
        do
            echo " $i ${var_install_sonarr_software_array_alpine[$i]}"
        done
        for i in "${!var_install_sonarr_software_array_alpine[@]}"
        do
            echo "- and currently installing: $i ${var_install_sonarr_software_array_alpine[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                doas $(f_get_distro_packager) add ${var_install_sonarr_software_array_alpine[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_sonarr_software_array_alpine[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
         for i in "${!var_install_sonarr_software_array_debian[@]}"
        do
            echo "- and currently installing: $i ${var_install_sonarr_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_sonarr_software_array_debian[$i]}
                curl -o install-sonarr.sh https://raw.githubusercontent.com/Sonarr/Sonarr/develop/distribution/debian/install.sh
                sudo bash install-sonarr.sh
            else
                $(f_get_distro_packager) install -y ${var_install_sonarr_software_array_debian[$i]}
                curl -o install-sonarr.sh https://raw.githubusercontent.com/Sonarr/Sonarr/develop/distribution/debian/install.sh
                bash install-sonarr.sh
            fi
        done
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_sonarr_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_sonarr_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_sonarr_software_array[$i]}
            else
                $(f_get_distro_packager) install -y ${var_install_sonarr_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_sonarr_software_array_debian[@]}"
        do
            echo "- and c1urrently installing: $i ${var_install_sonarr_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_sonarr_software_array_debian[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_sonarr_software_array_debian[$i]}  
            fi
            # echo "- Rebooting the network";
            # sudo systemctl restart networking.service 
        done
    fi
    f_update_software
}
