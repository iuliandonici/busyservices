#!/bin/bash
var_install_enl_software_array=("enlightenment" "efl" "lightdm" "python3" "networkmanager" "networkmanager-tui" "networkmanager-cli" "network-manager-applet" "networkmanager-wifi" "virt-manager" "vlc")
function f_install_enl_requirements() {
    source functions/f_update_software.sh
    source functions/f_get_distro_packager.sh
    source functions/f_config_enl.sh
    # source functions/f_config_kde_networking.sh
    f_update_software
    echo "- Installing Enlightenment desktop environment:"
    echo "- and here's a list of base software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_base_software_array[@]}"
    do
        echo " $i ${var_install_enl_software_array[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ $(f_check_networks) == "UP" ]]; then
            f_update_software
            for i in "${!var_install_enl_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_enl_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    doas $(f_get_distro_packager) add ${var_install_enl_software_array[$i]}  
                else
                    $(f_get_distro_packager) add ${var_install_enl_software_array[$i]}  
                fi
            done
        else
            echo "- but can't install them because the networks are down;"
        fi
    f_config_enl
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_enl_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_enl_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_enl_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_enl_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_enl_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_enl_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_enl_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_enl_software_array[$i]}  
            fi
        done
    fi
    # f_config_kde_networking
 }
 f_install_enl_requirements
