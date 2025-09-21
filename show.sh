#!/bin/bash
function f_config_kvm_network_interfaces() {
    echo "- Creating the network interfaces yaml file;"
    sudo rm -rf /etc/network/interfaces
# Assign a variable to the network interface we find (en* or eth)
    var_f_config_kvm_network_interfaces=$(ip a | grep -E "en|eth[[0-9]]" | sed -e 's/://g' | grep -Ev "lo|wl|br|virb|altname " | awk '{print $2}')
    echo -e "# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback \n
# Specify that the physical interface that should be connected to the bridge
# should be configured manually, to avoid conflicts with NetworkManager" >> config_kvm_network_interfaces.yaml
# If the network interface variable isn't empty, then apply the default config
    if [ ! -z "${var_f_config_kvm_network_interfaces}" ]; then
        echo "- The network interface variable isn't empty so we're going tu use a default yaml config;"
        echo -e "auto $var_f_config_kvm_network_interfaces
iface $var_f_config_kvm_network_interfaces inet manual \n" >> config_kvm_network_interfaces.yaml
        echo "# The bridge0 bridge settings
auto bridge0
iface bridge0 inet static
   address 192.168.50.16
   netmask 255.255.255.0
   network 192.168.50.0
   broadcast 192.168.50.255
   gateway 192.168.50.1
   dns-nameservers 192.168.50.1
   bridge_ports $var_f_config_kvm_network_interfaces
#    bridge_stp      off
#    bridge_maxwait  0
#    bridge_fd       0" >> config_kvm_network_interfaces.yaml
# If the network interface variable is empty then create a default eth0 interface
    else 
        echo "- The network interface variable is empty so we're creating eth0 as a default one;"
        var_f_config_kvm_network_interfaces="eth0"
        echo -e "auto $var_f_config_kvm_network_interfaces
iface $var_f_config_kvm_network_interfaces inet manual \n" >> config_kvm_network_interfaces.yaml
echo "# The bridge0 bridge settings
auto bridge0
iface bridge0 inet static
   address 192.168.50.16
   netmask 255.255.255.0
   network 192.168.50.0
   broadcast 192.168.50.255
   gateway 192.168.50.1
   dns-nameservers 192.168.50.1
   bridge_ports $var_f_config_kvm_network_interfaces
#    bridge_stp      off
#    bridge_maxwait  0
#    bridge_fd       0" >> config_kvm_network_interfaces.yaml
    fi
    sudo cp -r config_kvm_network_interfaces.yaml /etc/network/interfaces
    rm -rf config_kvm_network_interfaces.yaml
}
f_config_kvm_network_interfaces