#!/bin/bash
function f_config_kvm_virtual_network() {
    echo "- Creating a virtual bridged network;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo rc-service virtqemud restart
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            # cp -r functions/f_config_kvm_virtual_network.xml .
            rc-service libvirtd restart
            rc-service virtqemud restart
            virsh net-define functions/f_config_kvm_virtual_network.xml
            virsh net-start bridged-network
            virsh net-autostart bridged-network
        fi
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo systemctl restart virtqemud
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            systemctl restart virtqemud
            # cp -r functions/f_config_kvm_virtual_network.xml .
            virsh net-define functions/f_config_kvm_virtual_network.xml
            virsh net-start bridged-network
            virsh net-autostart bridged-network
        fi
    else
        if [[ "$EUID" -ne 0 ]]; then 
            sudo systemctl restart virtqemud
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            systemctl restart virtqemud
            # cp -r functions/f_config_kvm_virtual_network.xml .
            virsh net-define functions/f_config_kvm_virtual_network.xml
            virsh net-start bridged-network
            virsh net-autostart bridged-network
        fi
    fi
}
