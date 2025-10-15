#!/bin/bash
function f_config_kvm_network_interfaces() {
    echo "- Creating the network interfaces yaml file;"
    echo "- currently generating a random MAC address for the bridge interface;"
    var_f_config_kvm_network_interfaces_macaddr=$(echo $FQDN|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')
    echo "- currently removing the previous network interfaces file being root or not;"
    if [[ "$EUID" -ne 0 ]]; then
        sudo rm -rf /etc/network/interfaces
    else 
        rm -rf /etc/network/interfaces
    fi
    echo -e "# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
# source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback \n
# Specify that the physical interface that should be connected to the bridge
# should be configured manually, to avoid conflicts with NetworkManager" >> config_kvm_network_interfaces.yaml
    var_f_config_kvm_network_wired_interfaces=$(ip a | grep -E "en.*:|es.*:|eth[0-99]:" | awk '{print $2}' | sed -e 's/://g')
    var_f_config_kvm_network_wired_interfaces_status=$(ip a | grep -E "en.*:|es.*:|eth[0-99]:" | awk '{print $9}' | sed -e 's/://g')
    var_f_config_kvm_network_wireless_interfaces=$(ip a | grep -E "wl.*:" | awk '{print $2}' | sed -e 's/://g')
    var_f_config_kvm_network_wireless_interfaces_status=$(ip a | grep -E "wl.*:" | awk '{print $9}' | sed -e 's/://g')
     if [ ! -z "${var_f_config_kvm_network_wired_interfaces}" ] && [ ! -z "${var_f_config_kvm_network_wireless_interfaces}" ]; then
        echo "- We found both network interfaces:"
        if [[ "$var_f_config_network_wired_interfaces_status" -eq "DOWN" && "$var_f_config_network_wired_interfaces_status" -eq "DOWN|UP" ]]; then
            echo "- but wired ($var_f_config_kvm_network_wired_interfaces) interface is $var_f_config_kvm_network_wired_interfaces_status;"
            echo "- and wireless ($var_f_config_kvm_network_wireless_interfaces) interface is $var_f_config_kvm_network_wireless_interfaces_status so we're going to use NAT for our local KVM which means we won't modify anything in our network config;"
        elif [[ "$var_f_config_network_wired_interfaces_status" -eq "UP" && "$var_f_config_network_wireless_interfaces_status" -eq "DOWN|UP" ]]; then
            echo "- but wireless ($var_f_config_kvm_network_wireless_interfaces) interface is $var_f_config_kvm_network_wireless_interfaces_status;"
            echo "- and wired ($var_f_config_kvm_network_wired_interfaces) interface is $var_f_config_kvm_network_wired_interfaces_status so we're going to create a bridge for our local KVM;"
            echo -e "auto $var_f_config_kvm_network_wired_interfaces
iface $var_f_config_kvm_network_wired_interfaces inet manual \n" >> config_kvm_network_interfaces.yaml
        echo "# The bridge0 bridge settings
auto bridge0
iface bridge0 inet dhcp
#    address 192.168.50.12
#    netmask 255.255.255.0
#    network 192.168.50.0
#    broadcast 192.168.50.255
#    gateway 192.168.50.1
#    dns-nameservers 192.168.50.1
   hwaddress $var_f_config_kvm_network_interfaces_macaddr
   bridge_ports $var_f_config_kvm_network_wired_interfaces
   bridge_stp      off
   bridge_maxwait  0
   bridge_fd       0" >> config_kvm_network_interfaces.yaml
        fi
    elif [ -z "${var_f_config_kvm_network_wired_interfaces}" ] || [ -z "${var_f_config_kvm_network_wireless_interfaces}" ]; then
        echo "- and since the network interface variable is empty, we're creating a eth0 as a default one;"
        var_f_config_kvm_network_wired_interfaces="eth0"
        echo -e "auto $var_f_config_kvm_network_wired_interfaces
iface $var_f_config_kvm_network_wired_interfaces inet manual \n" >> config_kvm_network_interfaces.yaml
echo "# The bridge0 bridge settings
auto bridge0
iface bridge0 inet dhcp
#    address 192.168.50.12
#    netmask 255.255.255.0
#    network 192.168.50.0
#    broadcast 192.168.50.255
#    gateway 192.168.50.1
#    dns-nameservers 192.168.50.1
   hwaddress $var_f_config_kvm_network_interfaces_macaddr
   bridge_ports $var_f_config_kvm_network_wired_interfaces
   bridge_stp      off
   bridge_maxwait  0
   bridge_fd       0" >> config_kvm_network_interfaces.yaml
    fi
    if [[ "$EUID" -ne 0 ]]; then 
        sudo cp -r config_kvm_network_interfaces.yaml /etc/network/interfaces
    else
        cp -r config_kvm_network_interfaces.yaml /etc/network/interfaces
    fi
    rm -rf config_kvm_network_interfaces.yaml
}