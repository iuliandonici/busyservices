#!/bin/bash
function f_config_kvm_libvirtd() {
    echo " - Configuring KVM for remote ssh;"
    if [[ "$EUID" -ne 0 ]]; then 
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
        fi
        sudo rc-service libvirtd stop
        sudo rm -rf /etc/libvirt/libvirt.conf
        sudo cp -r functions/f_config_kvm_libvirtd /etc/libvirt/libvirt.conf
        sudo rc-service libvirtd start
    else
        rc-service libvirtd stop
        rm -rf /etc/libvirt/libvirt.conf
        cp -r functions/f_config_kvm_libvirtd /etc/libvirt/libvirt.conf
        rc-service libvirtd start
    fi    
}