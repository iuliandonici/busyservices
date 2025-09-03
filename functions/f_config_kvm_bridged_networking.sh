#!/bin/bash
function f_config_kvm_bridged_networking() {
    echo " - Creating a bridged network interface so we can get the same subnet IPs as the KVM host;"
#     sudo cat > ifcfg-ens33 <<EOF
# DEVICE=ens33
# HWADDR=1c:c1:de:57:32:d7
# ONBOOT=yes
# BRIDGE=bridge0
# NM_CONTROLLED=no
# EOF
#     sudo cat > ifcfg-bridge0 <<EOF
# DEVICE=bridge0
# TYPE=Bridge
# BOOTPROTO=dhcp
# ONBOOT=yes
# DELAY=0
# NM_CONTROLLED=no
# EOF
#     sudo cat >> /etc/sysctl.conf <<EOF
# net.bridge.bridge-nf-call-ip6tables = 0
# net.bridge.bridge-nf-call-iptables = 0
# net.bridge.bridge-nf-call-arptables = 0
# EOF
    # sudo sysctl -p /etc/sysctl.conf
    sudo rm -rf /etc/network/interfaces
    sudo cp -r functions/f_config_kvm_network_interfaces.yaml /etc/network/interfaces
    sudo cp -r functions/f_config_kvm_netfilter_bridge /etc/sysctl.d/99-kvm-netfilter-bridge.conf
    sudo ip link add bridge0 type bridge
    # sudo ip link set ens33 master bridge0
    sudo ip address add dev bridge0 192.168.50.0/24
    sudo modprobe br_netfilter
    sudo echo "br_netfilter" >> br_netfilter.conf
    sudo mv br_netfilter.conf /etc/modules-load.d/br_netfilter.conf
    sudo sysctl -p /etc/sysctl.d/99-kvm-netfilter-bridge.conf
}