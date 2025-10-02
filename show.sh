#!/bin/bash
function f_install_kde() {
    setup-xorg-base
    sudo apk add  plasma elogind polkit-elogind kde-applications font-terminus font-inconsolata font-dejavu font-noto font-noto-cjk font-awesome font-noto-extra font-liberation python3
    sudo rc-update add sddm
    git clone git@github.com:iuliandonici/busychrome-audio.git
    cd busychrome-audio/
    sudo ./setup-audio --force-avs-install
    sudo reboot
}
function f_config_kde() {
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then
            sudo rc-update add sddm
            git clone git@github.com:iuliandonici/busychrome-audio.git
            cd busychrome-audio/
            sudo ./setup-audio --force-avs-install
        else
            rc-update add sddm
            clone git@github.com:iuliandonici/busychrome-audio.git
            cd busychrome-audio/
            ./setup-audio --force-avs-install
        fi
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        echo "- No tests done for dns/zypper;"
    else
        echo "- No tests done for this distro;"
    fi
}










#!/bin/bash
var_install_kde_software_array=("setup-xorg-base" "plasma elogind" "polkit-elogind" "kde-applications" "font-terminus" "font-inconsolata" "font-dejavu" "font-noto" "font-noto-cjk" "font-awesome" "font-noto-extra" "font-liberation" "python3")
function f_install_kde_requirements() {
    source functions/f_update_software.sh
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
 }
 function f_config_kde() {

 }