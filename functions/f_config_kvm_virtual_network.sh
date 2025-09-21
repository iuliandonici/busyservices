#!/bin/bash
function f_config_kvm_virtual_network() {
    echo "- Creating a virtual bridged network;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo rc-update add libvirtd
            sudo rc-service libvirtd restart
            sudo rc-update add virtnedworkd
            sudo rc-service virtnetworkd restart
            sudo rc-update add virtqemud
            sudo rc-service virtqemud restart
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            # cp -r functions/f_config_kvm_virtual_network.xml .
            rc-update add libvirtd
            rc-service libvirtd restart
            rc-update add virtnedworkd
            rc-service virtnetworkd restart
            rc-update add virtqemud
            rc-service virtqemud restart            virsh net-define functions/f_config_kvm_virtual_network.xml
            virsh net-start bridged-network
            virsh net-autostart bridged-network
        fi
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo systemctl restart libvirtd
            sudo systemctl restart virtnetworkd
            sudo systemctl restart virtqemud
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            # cp -r functions/f_config_kvm_virtual_network.xml .
            systemctl restart libvirtd
            systemctl restart virtnetworkd
            systemctl restart virtqemud
            virsh net-define functions/f_config_kvm_virtual_network.xml
            virsh net-start bridged-network
            virsh net-autostart bridged-network
        fi
    else
        if [[ "$EUID" -ne 0 ]]; then 
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo systemctl restart libvirtd
            sudo systemctl restart virtnetworkd
            sudo systemctl restart virtqemud
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            # cp -r functions/f_config_kvm_virtual_network.xml .
            systemctl restart libvirtd
            systemctl restart virtnetworkd
            systemctl restart virtqemud
            virsh net-define functions/f_config_kvm_virtual_network.xml
            virsh net-start bridged-network
            virsh net-autostart bridged-network
        fi
    fi
}
