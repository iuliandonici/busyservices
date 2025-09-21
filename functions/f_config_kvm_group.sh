#!/bin/bash
function f_config_kvm_group() {
    echo "- Creating users and groups for KVM;"
    if [[ "$EUID" -ne 0 ]]; then 
        sudo usermod -aG kvm,libvirt $USER
        newgrp libvirt
    else
        usermod -aG kvm,libvirt $USER
        newgrp libvirt
    fi    
}