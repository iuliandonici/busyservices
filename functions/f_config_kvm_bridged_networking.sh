#!/bin/bash
function f_config_kvm_bridged_networking() {
    echo "- Creating a bridged network interface so we can get the same subnet IPs as the KVM host;"
    if [[ "$EUID" -ne 0 ]]; then 
        sudo cp -r functions/f_config_kvm_netfilter_bridge /etc/sysctl.d/99-kvm-netfilter-bridge.conf
        sudo ip link add bridge0 type bridge
        # sudo ip link set ens33 master bridge0
        sudo ip address add dev bridge0 192.168.50.0/24
        sudo modprobe br_netfilter
        sudo echo "br_netfilter" >> br_netfilter.conf
        sudo mv br_netfilter.conf /etc/modules-load.d/br_netfilter.conf
        sudo sysctl -p /etc/sysctl.d/99-kvm-netfilter-bridge.conf
    else
        cp -r functions/f_config_kvm_netfilter_bridge /etc/sysctl.d/99-kvm-netfilter-bridge.conf
        ip link add bridge0 type bridge
        # sudo ip link set ens33 master bridge0
        ip address add dev bridge0 192.168.50.0/24
        modprobe br_netfilter
        echo "br_netfilter" >> br_netfilter.conf
        mv br_netfilter.conf /etc/modules-load.d/br_netfilter.conf
        sysctl -p /etc/sysctl.d/99-kvm-netfilter-bridge.conf
    fi
}