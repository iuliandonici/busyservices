#!/bin/bash
function f_config_kvm_libirtd() {
    sudo systemctl stop libvirtd
    sudo rm -rf /etc/libvirt/libvirt.conf
    sudo cp -r functions/f_config_kvm_libvirtd /etc/libvirt/libvirt.conf
    sudo systemctl start libvirtd
}