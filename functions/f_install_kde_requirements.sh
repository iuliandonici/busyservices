#!/bin/bash
var_install_kde_software_array=("plasma elogind" "polkit-elogind" "kde-applications-admin" "kde-applications" "kde-applications-network" "kde-applications-utils" "kde-applications-base" "font-terminus" "font-inconsolata" "font-dejavu" "font-noto" "font-noto-cjk" "font-awesome" "font-noto-extra" "font-liberation" "python3" "networkmanager" "networkmanager-tui" "networkmanager-cli" "plasma-nm" "network-manager-applet" "networkmanager-wifi" "iwd")
function f_install_kde_requirements() {
    source functions/f_update_software.sh
    source functions/f_config_kde.sh
    source functions/f_install_busychrome_audio.sh
    echo "- Installing KDE desktop environment;"
    f_update_software
    echo "- List of extra software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_kde_software_array[@]}"
    do
        echo " $i ${var_install_kde_software_array[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_kde_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_kde_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) add ${var_install_kde_software_array[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_kde_software_array[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_kde_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_kde_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_kde_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_kde_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
            fi
        done
    fi
    f_update_software
    f_config_kde
    f_update_software
    # f_install_busychrome_audio
    f_update_software
 }