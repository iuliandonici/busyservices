#!/bin/bash
function f_config_kvm_virtual_network() {
    echo "- Creating a virtual bridged network;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo mkdir -p /etc/polkit-1/localauthority/50-local.d/
            sudo echo "[Remote libvirt SSH access]
 Identity=unix-group:libvirt
 Action=org.libvirt.unix.manage
 ResultAny=yes
 ResultInactive=yes
 ResultActive=yes" > 50-libvirt-ssh-remote-access-policy.pkla
            sudo mv 50-libvirt-ssh-remote-access-policy.pkla /etc/polkit-1/localauthority/50-local.d/
            sudo rc-update add libvirtd
            sudo rc-service libvirtd start
            sudo modprobe tun
            sudo echo "tun" >> tun.conf
            sudo mv tun.conf /etc/modules-load.d/
            sudo cat /etc/modules | grep tun || echo tun >> /etc/modules
            # sudo rc-service libvirtd
            # sudo rc-update add virtnetworkd
            # sudo rc-service virtnetworkd restart
            # sudo rc-update add virtqemud
            # sudo rc-service virtqemud restart
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            # cp -r functions/f_config_kvm_virtual_network.xml 
            mkdir -p /etc/polkit-1/localauthority/50-local.d/
            echo "[Remote libvirt SSH access]
 Identity=unix-group:libvirt
 Action=org.libvirt.unix.manage
 ResultAny=yes
 ResultInactive=yes
 ResultActive=yes" > 50-libvirt-ssh-remote-access-policy.pkla
            mv 50-libvirt-ssh-remote-access-policy.pkla /etc/polkit-1/localauthority/50-local.d/
            rc-update add libvirtd
            rc-service libvirtd start
            modprobe tun
            echo "tun" >> /etc/modules-load.d/tun.conf
            cat /etc/modules | grep tun || echo tun >> /etc/modules
            # rc-service libvirtd
            # rc-update add virtnetworkd
            # rc-service virtnetworkd restart
            # rc-update add virtqemud
            # rc-service virtqemud restart
            virsh net-define functions/f_config_kvm_virtual_network.xml
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
