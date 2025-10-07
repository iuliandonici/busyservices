#!/bin/bash
var_install_base_software_array=("bash" "apt-utils" "lsb-release" "hostname" "wget" "rsync" "curl" "keychain" "net-tools" "unzip" "git" "nano" "ca-certificates" "curl" "gnupg" "software-properties-common" "acl" "openssh-server-pam")
function f_install_base_software() {
    source functions/f_update_software.sh
    source functions/f_config_git.sh
    f_update_software
    echo "- List of base software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_base_software_array[@]}"
    do
        echo " $i ${var_install_base_software_array[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_base_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_base_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
               sudo $(f_get_distro_packager) add ${var_install_base_software_array[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_base_software_array[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_base_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_base_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_base_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_base_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_base_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_base_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_base_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_base_software_array[$i]}  
            fi
        done
    fi
    f_config_git
}