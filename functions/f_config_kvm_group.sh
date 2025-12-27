#!/bin/bash
function f_config_kvm_group() {
    echo "- Creating users and groups for KVM;"
    source functions/f_get_distro_packager.sh
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            doas addgroup $USER kvm
            doas addgroup $USER libvirt
            doas addgroup $USER wheel
            doas addgroup $USER qemu
            doas addgroup busyneo kvm
            doas addgroup busyneo libvirt
            doas addgroup busyneo wheel
            doas addgroup busyneo qemu
        else
            addgroup $USER kvm
            addgroup $USER libvirt
            addgroup $USER wheel
            addgroup $USER qemu
            addgroup busyneo kvm
            addgroup busyneo libvirt
            addgroup busyneo wheel
            addgroup busyneo qemu
        fi    
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo usermod -aG kvm,libvirt,wheel,qemu $USER
            sudo newgrp libvirt
        else
            usermod -aG kvm,libvirt,wheel,qemu $USER
            # newgrp libvirt
        fi
    else
        if [[ "$EUID" -ne 0 ]]; then 
            echo "-then this"
            sudo usermod -aG kvm,libvirt $USER
            # sudo newgrp libvirt
        else
            usermod -aG kvm,libvirt $USER
            # newgrp libvirt
        fi
    fi
}
