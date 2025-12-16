#!/bin/bash
var_disable_systemd_networkd_wait_online_services_array=("systemd-networkd-wait-online")
function f_disable_systemd_networkd_wait_online() {
  echo "- Currently removing the ${var_disable_systemd_networkd_wait_online_services_array[$i]} service;"
  
  for i in "${!var_disable_systemd_networkd_wait_online_services_array[@]}"
  do
      echo "- currently removing: $i ${var_disable_systemd_networkd_wait_online_services_array[$i]}"
      if [[ "$EUID" -ne 0 ]]; then 
        sudo systemctl disable ${var_disable_systemd_networkd_wait_online_services_array[$i]}.service 
      else
        systemctl disable ${var_disable_systemd_networkd_wait_online_services_array[$i]}.service 
      fi
  done
}
