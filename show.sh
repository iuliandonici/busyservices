#!/bin/bash
function f_check_networks() {
  var_f_config_network_wired_interfaces=$(ip a | grep -E "en.*:|es.*:|eth[0-99]:" | awk '{print $2}' | sed -e 's/://g')
  var_f_config_network_wired_interfaces_status=$(ip a | grep -E "en.*:|es.*:|eth[0-99]:" | awk '{print $9}' | sed -e 's/://g')
  if [[ $var_f_config_network_wired_interfaces_status == "bridge0" ]]; then
    var_f_config_network_wired_interfaces_status=$(ip a | grep -E "en.*:|es.*:|eth[0-99]:" | awk '{print $11}' | sed -e 's/://g')
  fi
  var_f_config_network_wireless_interfaces=$(ip a | grep -E "wl.*:" | awk '{print $2}' | sed -e 's/://g')
  var_f_config_network_wireless_interfaces_status=$(ip a | grep -E "wl.*:" | awk '{print $9}' | sed -e 's/://g')
  if ([[ -z $var_f_config_kvm_network_wired_interfaces ]] && [[ ! -z $var_f_config_network_wireless_interfaces ]]) || ([[ ! -z $var_f_config_kvm_network_wired_interfaces ]] && [[ -z $var_f_config_network_wireless_interfaces ]]); then
    if ([[ $var_f_config_network_wired_interfaces_status == "UP" ]] || [[ $var_f_config_network_wireless_interfaces_status == "UP" ]]); then
      echo "UP"
    else 
      echo "DOWN"
    fi
  fi
}
f_check_networks
