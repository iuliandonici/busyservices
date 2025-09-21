#!/bin/bash
function f_config_kvm_network_interfaces() {
# Assign a variable to the network interface we find (en* or eth)
    var_f_config_kvm_network_interfaces=$(ip a | grep -E "en|eth[[0-9]]" | sed -e 's/://g' | grep -Ev "lo|wl|virb" | awk '{print $2}')
    echo $var_f_config_kvm_network_interfaces
}