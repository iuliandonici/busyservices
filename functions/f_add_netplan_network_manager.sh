#!/bin/bash
var_add_netplan_network_manager_spacer="    "
function f_add_netplan_network_manager() {
  source functions/f_get_distro_packager.sh
  echo "- Currently configuring netplan:"
  if [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
    if [[ "$EUID" -ne 0 ]]; then 
      if sudo grep -wq "renderer" "/etc/netplan/50-cloud-init.yaml"; then
        echo "- but NetworkManager as renderer is already being used;"
      else
        sudo chmod 0600 /etc/netplan/*.yaml
        echo "${var_add_netplan_network_manager_spacer}renderer: NetworkManager" | sudo tee -a /etc/netplan/50-cloud-init.yaml
        sudo netplan apply
      fi
    else
      if grep -wq "renderer" "/etc/netplan/50-cloud-init.yaml"; then
        echo "- but NetworkManager as renderer is already being used;"
      else
        chmod 0600 /etc/netplan/*.yaml
        echo "${var_add_netplan_network_manager_spacer}renderer: NetworkManager" | tee -a /etc/netplan/50-cloud-init.yaml
        netplan apply
      fi
    fi
  else
    echo "- but this function hasn't been tested on this os;"
  fi
}
