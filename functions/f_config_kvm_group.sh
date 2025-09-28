#!/bin/bash
function f_config_kvm_group() {
    echo "- Creating users and groups for KVM;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo addgroup $USER kvm
            sudo addgroup $USER libvirt
            sudo addgroup $USER qemu
            sudo addgroup $USER wheel
            sudo addgroup busyneo kvm
            sudo addgroup busyneo libvirt
            sudo addgroup busyneo qemu
            sudo addgroup busyneo wheel
        else
            addgroup $USER kvm
            addgroup $USER libvirt
            addgroup $USER qemu
            addgroup $USER wheel
            addgroup busyneo kvm
            addgroup busyneo libvirt
            addgroup busyneo qemu
            addgroup busyneo wheel
        fi    
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo usermod -aG kvm,libvirt,qemu,qheel $USER
            sudo newgrp libvirt
        else
            usermod -aG kvm,libvirt,qemu,qheel $USER
            newgrp libvirt
        fi
    else
        if [[ "$EUID" -ne 0 ]]; then 
            sudo usermod -aG kvm,libvirt,wheel,qemu $USER
            sudo newgrp libvirt
        else
            usermod -aG kvm,libvirt,wheel,qemu $USER
            newgrp libvirt
        fi  
    fi
}