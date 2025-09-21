#!/bin/bash
function f_config_kvm_group() {
    echo "- Creating users and groups for KVM;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo addgroup $USER libvirt
            sudo addgroup $USER kvm
            sudo addgroup $USER qemu
            sudo addgroup busyneo libvirt
            sudo addgroup busyneo kvm
            sudo addgroup busyneo qemu
        else
            addgroup $USER,busyneo libvirt
        fi    
    # usermod -aG kvm,libvirt $USER
    # newgrp libvirt
    fi
}