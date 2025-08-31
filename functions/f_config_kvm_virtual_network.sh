#!/bin/bash
function f_config_kvm_virtual_network() {
    mkdir tmp
    sudo cp -r functions/f_config_kvm_virtual_network.xml tmp/
    sudo virsh net-define tmp/f_config_kvm_virtual_network.xml
    sudo virsh net-start bridged-network
    sudo virsh net-autostart bridged-network
}
