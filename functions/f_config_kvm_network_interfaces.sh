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
    echo "- and assigning a variable to the network interface we find (en* or eth);"
    var_f_config_kvm_network_wired_interfaces=$(ip a | grep -E "en.*:|es.*:|eth[0-99]:" | awk '{print $2}' | sed -e 's/://g')
    # var_f_config_kvm_network_wireless_interfaces=$(ip a | grep -E "wl.*:" | awk '{print $2}' | sed -e 's/://g')
    # if [ -z "$var_f_config_network_wireless_interfaces" && "$var_f_config_kvm_network_wireless_interfaces"]; then

    # fi
    echo -e "# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
# source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback \n
# Specify that the physical interface that should be connected to the bridge
# should be configured manually, to avoid conflicts with NetworkManager" >> config_kvm_network_interfaces.yaml
# If the network interface variable isn't empty, then apply the default config
    if [ ! -z "${var_f_config_kvm_network_wired_interfaces}" ]; then
        echo "- but the network interface variable isn't empty so we're going tu use a default yaml config;"
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
# If the network interface variable is empty then create a default eth0 interface
    else 
        echo "- and since the network interface variable is empty, we're creating eth0 as a default one;"
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