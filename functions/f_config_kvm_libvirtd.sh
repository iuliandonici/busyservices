#!/bin/bash
function f_config_kvm_libvirtd() {
    echo "- Configuring KVM for remote ssh;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo rc-service libvirtd stop
            sudo rm -rf /etc/libvirt/libvirt.conf
            sudo cp -r functions/f_config_kvm_libvirtd /etc/libvirt/libvirt.conf
            sudo rc-service libvirtd start
        else
            rc-service libvirtd stop
            rm -rf /etc/libvirt/libvirt.conf
            cp -r functions/f_config_kvm_libvirtd /etc/libvirt/libvirt.conf
            rc-service libvirtd start
        fi
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
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
    else
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
    fi
}