#!/bin/bash
var_install_desktop_dev_software_array=("vlc" "timeshift" "brave-browser" "codium" "virt-manager" "libvirt-clients" "gnome-shell-extension-manager" "gnome-shell-extensions" "gnome-browser-connector" "gir1.2-gtop-2.0" "gir1.2-nm-1.0" "gir1.2-clutter-1.0" "gnome-system-monitor")
function f_install_desktop_dev_software() {
    source functions/f_update_software.sh
    source functions/f_add_repo_brave_browser.sh
    source functions/f_add_repo_vscodium.sh
    source functions/f_config_applet_temperature_indicator.sh
    source functions/f_config_applet_multicore_system_monitor.sh
    f_update_software
    f_add_repo_brave_browser
    f_update_software
    f_add_repo_vscodium
    f_update_software
    echo "- List of extra software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_desktop_dev_software_array[@]}"
    do
        echo " $i ${var_install_desktop_dev_software_array[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_desktop_dev_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_desktop_dev_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) add ${var_install_desktop_dev_software_array[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_desktop_dev_software_array[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_desktop_dev_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_desktop_dev_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_desktop_dev_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_desktop_dev_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_desktop_dev_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_desktop_dev_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_desktop_dev_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_desktop_dev_software_array[$i]}  
            fi
        done
    fi
    f_update_software
    f_config_applet_temperature_indicator
    f_config_applet_multicore_system_monitor
}