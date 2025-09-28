#!/bin/bash
function f_config_kvm_group() {
    echo "- Creating users and groups for KVM;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo addgroup $USER kvm
            sudo addgroup $USER libvirt
            sudo addgroup $USER sudo
            sudo addgroup $USER qemu
            sudo addgroup $USER wheel
            sudo addgroup busyneo kvm
            sudo addgroup busyneo libvirt
            sudo addgroup busyneo sudo
            sudo addgroup busyneo qemu
            sudo addgroup busyneo wheel
        else
            addgroup $USER kvm
            addgroup $USER libvirt
            addgroup $USER sudo
            addgroup $USER qemu
            addgroup $USER wheel
            addgroup busyneo kvm
            addgroup busyneo libvirt
            addgroup busyneo sudo
            addgroup busyneo qemu
            addgroup busyneo wheel
        fi    
    # usermod -aG kvm,libvirt $USER
    # newgrp libvirt
    fi
}