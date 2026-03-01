#!/bin/bash
var_install_xfce_software_array=("")
var_install_xfce_software_array_alpine=("adwaita-xfce-icon-theme" "adw-gtk3" "font-dejavu" "lightdm-gtk-greeter" "python3"  "networkmanager" "networkmanager-tui" "networkmanager-cli" "network-manager-applet" "networkmanager-wifi" "virt-manager" "vlc" "xfce4" "xfce-polkit" "xfce4-terminal" "xfce4-screensaver")
function f_install_xfce() {
    source functions/f_update_software.sh
    source functions/f_get_distro_packager.sh
    source functions/f_config_xfce.sh
    source functions/f_config_xfce_networking.sh
    echo " - Installing Xfce desktop environment:"
    if [[ $(f_check_networks) == "UP" ]]; then
        if [[ $(f_get_distro_packager) == "apk" ]]; then
            echo "- and here's a list of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_xfce_software_array_alpine[@]}"
            do
                echo " $i ${var_install_xfce_software_array_alpine[$i]}"
            done
            f_update_software
            for i in "${!var_install_xfce_software_array_alpine[@]}"
            do
                echo "- and currently installing: $i ${var_install_xfce_software_array_alpine[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) add ${var_install_xfce_software_array[$i]}  
                else
                    $(f_get_distro_packager) add ${var_install_xfce_software_array[$i]}  
                fi
            done
        f_config_xfce
        elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
            echo "- and here's a list of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_xfce_software_array[@]}"
            do
                echo " $i ${var_install_xfce_software_array[$i]}"
            done
            f_update_software
            for i in "${!var_install_xfce_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_xfce_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) install -y ${var_install_xfce_software_array[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_xfce_software_array[$i]}  
                fi
            done        
        else
            echo "- and here's a list of base software that will be installed using $(f_get_distro_packager):"
            for i in "${!var_install_xfce_software_array[@]}"
            do
                echo " $i ${var_install_xfce_software_array[$i]}"
            done
            f_update_software
            for i in "${!var_install_xfce_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_xfce_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    $(f_get_security_utility) $(f_get_distro_packager) install -y ${var_install_xfce_software_array[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_xfce_software_array[$i]}  
                fi
            done
        fi
        f_config_xfce_networking
    else
        echo "- but can't install them because the networks are down;"
    fi
 }
