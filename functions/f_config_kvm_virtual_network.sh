#!/bin/bash
function f_config_kvm_virtual_network() {
    echo "- Creating a virtual bridged network;"
    # sudo cp -r functions/f_config_kvm_virtual_network.xml .
    sudo virsh net-define functions/f_config_kvm_virtual_network.xml
    sudo virsh net-start bridged-network
    sudo virsh net-autostart bridged-network
}
