#!/bin/bash
var_install_server_kvm_software_array=("qemu-kvm" "libvirt-daemon-system" "libvirt-clients" "bridge-utils" "ifupdown")
function f_install_server_kvm_software() {
    source functions/f_update_software.sh
    source functions/f_config_kvm_sshd.sh
    source functions/f_config_kvm_libvirtd.sh
    source functions/f_config_kvm_group.sh
    source functions/f_config_kvm_crontab.sh
    source functions/f_config_kvm_bridged_networking.sh
    source functions/f_config_kvm_virtual_network.sh
    f_update_software
    echo "- List of extra software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_server_kvm_software_array[@]}"
    do
        echo " $i ${var_install_server_kvm_software_array[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_server_kvm_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_server_kvm_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) add ${var_install_server_kvm_software_array[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_server_kvm_software_array[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_server_kvm_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_server_kvm_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_server_kvm_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_server_kvm_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_server_kvm_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_server_kvm_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_server_kvm_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_server_kvm_software_array[$i]}  
            fi
        done
    fi
    f_update_software
    f_config_kvm_sshd
    f_config_kvm_crontab
    f_config_kvm_bridged_networking
    f_config_kvm_virtual_network
    f_config_kvm_group
    f_config_kvm_libvirtd
    sudo reboot now
}