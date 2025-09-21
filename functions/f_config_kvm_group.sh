#!/bin/bash
function f_config_kvm_group() {
    echo "- Creating users and groups for KVM;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo addgroup $USER,busyneo kvm,libvirt,qemu
        else
            addgroup $USER,busyneo kvm,libvirt,qemu
        fi    
    # usermod -aG kvm,libvirt $USER
    # newgrp libvirt
    fi
}