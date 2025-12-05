#!/bin/bash
var_install_cockpit_software_array_debian=("cockpit" "cockpit-machines" "cockpit-storaged" "cockpit-networkmanager" "cockpit-packagekit" "ostree" "cockpit-machines" "cockpit-podman" "cockpit-sosreport")
function f_install_cockpit() {
    source functions/f_update_software.sh
    source functions/f_get_distro_packager.sh
    echo " - here's a list of extra software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_cockpit_software_array_debian[@]}"
    do
        echo " $i ${var_install_cockpit_software_array_debian[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_cockpit_software_array_debian[@]}"
        do
            echo "- Currently installing: $i ${var_install_cockpit_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                doas $(f_get_distro_packager) add ${var_install_cockpit_software_array_debian[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_cockpit_software_array_debian[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_cockpit_software_array_debian[@]}"
        do
            echo "- Currently installing: $i ${var_install_cockpit_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_cockpit_software_array_debian[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_cockpit_software_array_debian[$i]}  
            fi
        done        
    else
        . /etc/os-release
        for i in "${!var_install_cockpit_software_array_debian[@]}"
        do
            echo "- Currently installing: $i ${var_install_cockpit_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y -t ${VERSION_CODENAME}-backports ${var_install_cockpit_software_array_debian[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_cockpit_software_array_debian[$i]}  
            fi
        done
    fi
    f_update_software
}
