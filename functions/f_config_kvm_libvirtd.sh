#!/bin/bash
function f_config_kvm_libvirtd() {
    echo " - Configuring KVM for remote ssh;"
    if [[ "$EUID" -ne 0 ]]; then 
        sudo systemctl stop libvirtd
        sudo rm -rf /etc/libvirt/libvirt.conf
        sudo cp -r functions/f_config_kvm_libvirtd /etc/libvirt/libvirt.conf
        sudo systemctl start libvirtd
    else
        systemctl stop libvirtd
        rm -rf /etc/libvirt/libvirt.conf
        cp -r functions/f_config_kvm_libvirtd /etc/libvirt/libvirt.conf
        systemctl start libvirtd
    fi    
}