#!/bin/bash
var_install_kde_software_array=("plasma elogind" "polkit-elogind" "plasma-sdk" "kde-applications-admin" "kde-applications-network" "kde-applications-utils" "kde-applications-base" "font-terminus" "font-inconsolata" "font-dejavu" "font-noto" "font-noto-cjk" "font-awesome" "font-noto-extra" "font-liberation" "python3" "networkmanager" "networkmanager-tui" "networkmanager-cli" "plasma-nm" "network-manager-applet" "networkmanager-wifi" "virt-manager" "vlc" "gvfs-fuse" "udisks2" "device-mapper" "lvm2" "isoimagewriter")
var_install_kde_software_array_alpine=("plasma elogind" "polkit-elogind" "kde-applications-admin" "kde-applications-network" "kde-applications-utils" "kde-applications-base" "font-terminus" "font-inconsolata" "font-dejavu" "font-noto" "font-noto-cjk" "font-awesome" "font-noto-extra" "font-liberation" "python3" "networkmanager" "networkmanager-tui" "networkmanager-cli" "plasma-nm" "network-manager-applet" "networkmanager-wifi" "virt-manager" "vlc" "gvfs-fuse" "udisks2" "device-mapper" "lvm2" "isoimagewriter")
function f_install_kde_requirements() {
    source functions/f_update_software.sh
    source functions/f_get_distro_packager.sh
    source functions/f_config_kde.sh
    source functions/f_config_kde_networking.sh
    source functions/f_install_kde_themes.sh
    echo " - Installing KDE desktop environment:"
#    if [[ $(f_check_networks) == "UP" ]]; then
        if [[ $(f_get_distro_packager) == "apk" ]]; then
            echo "- and here's a list of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_kde_software_array_alpine[@]}"
            do
                echo " $i ${var_install_kde_software_array_alpine[$i]}"
            done
            f_update_software
            for i in "${!var_install_kde_software_array_alpine[@]}"
            do
                echo "- and currently installing: $i ${var_install_kde_software_array_alpine[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) add ${var_install_kde_software_array[$i]}  
                else
                    $(f_get_distro_packager) add ${var_install_kde_software_array[$i]}  
                fi
            done
#        f_install_kde_themes
        f_config_kde
        elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
            echo "- and here's a list of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_kde_software_array[@]}"
            do
                echo " $i ${var_install_kde_software_array[$i]}"
            done
            f_update_software
            for i in "${!var_install_kde_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_kde_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
                fi
            done        
        else
            echo "- and here's a list of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_kde_software_array[@]}"
            do
                echo " $i ${var_install_kde_software_array[$i]}"
            done
            f_update_software
            for i in "${!var_install_kde_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_kde_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_kde_software_array[$i]}  
                fi
            done
        fi
	f_install_kde_themes
        f_config_kde_networking
 #   else
 #       echo "- but can't install them because the networks are down;"
 #   fi
 }
