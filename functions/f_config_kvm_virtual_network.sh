#!/bin/bash
function f_config_kvm_virtual_network() {
    echo "- Creating a virtual bridged network:"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ ]]
        if [[ "$EUID" -ne 0 ]]; then 
            # Allow VMs to start and stop when the host does so
            sudo rc-update add libvirt-guests
            # sudo cp -r functions/f_config_kvm_virtual_network.xml .
            sudo mkdir -p /etc/polkit-1/localauthority/50-local.d/
            sudo echo "[Remote libvirt SSH access]
 Identity=unix-group:libvirt
 Action=org.libvirt.unix.manage
 ResultAny=yes
 ResultInactive=yes
 ResultActive=yes" > 50-libvirt-ssh-remote-access-policy.pkla
            sudo mv 50-libvirt-ssh-remote-access-policy.pkla /etc/polkit-1/localauthority/50-local.d/
            sudo rc-update add dbus
            sudo rc-update add dbus boot
            sudo rc-service dbus start
            sudo rc-update add libvirtd
            sudo rc-service libvirtd start
            sudo rc-service polkit restart
            sudo echo "tap" >> tap.conf
            sudo mv tap.conf /etc/modules-load.d/
            sudo cat /etc/modules | grep tan || sudo echo "tan" >> /etc/modules
            sudo modprobe tun
            sudo echo "tun" >> tun.conf
            sudo mv tun.conf /etc/modules-load.d/
            sudo cat /etc/modules | grep tun || doas echo "tun" >> /etc/modules
            sudo echo "allow bridge0" > bridge.conf
            sudo mv bridge.conf /etc/qemu/
            sudo echo "# Enable bridge forwarding.
#net.ipv4.conf.bridge0_bc_forwarding=1
net.ipv4.ip_forward=1
# Ignore iptables on bridge interfaces.
net.bridge.bridge-nf-call-iptables=0" > bridging.conf
            sudo mv bridging.conf /etc/sysctl.d/
            # sudo rc-service libvirtd
            # sudo rc-update add virtnetworkd
            # sudo rc-service virtnetworkd restart
            # sudo rc-update add virtqemud
            # sudo rc-service virtqemud restart
            sudo virsh net-define functions/f_config_kvm_virtual_network.xml
            sudo virsh net-start bridged-network
            sudo virsh net-autostart bridged-network
        else
            # Allow VMs to start and stop when the host does so
            rc-update add libvirt-guests
            # cp -r functions/f_config_kvm_virtual_network.xml 
            mkdir -p /etc/polkit-1/localauthority/50-local.d/
            echo "[Remote libvirt SSH access]
 Identity=unix-group:libvirt
 Action=org.libvirt.unix.manage
 ResultAny=yes
 ResultInactive=yes
 ResultActive=yes" > 50-libvirt-ssh-remote-access-policy.pkla
            mv 50-libvirt-ssh-remote-access-policy.pkla /etc/polkit-1/localauthority/50-local.d/
            rc-update add dbus
            rc-update add dbus boot
            rc-service dbus start
            rc-update add libvirtd
            rc-service libvirtd start
            rc-service polkit restart
            modprobe tun
            echo "tun" >> tun.conf
            mv tun.conf /etc/modules-load.d/
            cat /etc/modules | grep tun || echo tun >> /etc/modules
            echo "tap" >> tap.conf
            mv tap.conf /etc/modules-load.d/
            cat /etc/modules | grep tan || echo tan >> /etc/modules
            echo "allow bridge0" > bridge.conf
            mv bridge.conf /etc/qemu/
            echo "# Enable bridge forwarding.
#net.ipv4.conf.bridge0_bc_forwarding=1
net.ipv4.ip_forward=1
# Ignore iptables on bridge interfaces.
net.bridge.bridge-nf-call-iptables=0" > bridging.conf
            mv bridging.conf /etc/sysctl.d/
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
        if ([[ $var_f_config_kvm_network_wired_interfaces_status == "DOWN" ]] && [[ $var_f_config_kvm_network_wireless_interfaces_status == "UP" ]]); then
            echo "- but since the wired interface is DOWN and wireless is UP, we're not going to create a custom virtual network interface but instead we're going to use NAT, the default virtual network interface for KVM;"
            if [[ "$EUID" -ne 0 ]]; then 
                # sudo cp -r functions/f_config_kvm_virtual_network.xml .
                sudo systemctl restart libvirtd
                # sudo systemctl restart virtnetworkd
                # sudo systemctl restart virtqemud
                # sudo virsh net-define functions/f_config_kvm_virtual_network.xml
                # sudo virsh net-start bridged-network
                # sudo virsh net-autostart bridged-network
            else
                # cp -r functions/f_config_kvm_virtual_network.xml .
                systemctl restart libvirtd
                # systemctl restart virtnetworkd
                # systemctl restart virtqemud
                # virsh net-define functions/f_config_kvm_virtual_network.xml
                # virsh net-start bridged-network
                # virsh net-autostart bridged-network
            fi
        else
            if [[ "$EUID" -ne 0 ]]; then 
                # sudo cp -r functions/f_config_kvm_virtual_network.xml .
                sudo systemctl restart libvirtd
                # sudo systemctl restart virtnetworkd
                # sudo systemctl restart virtqemud
                sudo virsh net-define functions/f_config_kvm_virtual_network.xml
                sudo virsh net-start bridged-network
                sudo virsh net-autostart bridged-network
            else
                # cp -r functions/f_config_kvm_virtual_network.xml .
                systemctl restart libvirtd
                # systemctl restart virtnetworkd
                # systemctl restart virtqemud
                virsh net-define functions/f_config_kvm_virtual_network.xml
                virsh net-start bridged-network
                virsh net-autostart bridged-network
            fi
        fi
    fi
}