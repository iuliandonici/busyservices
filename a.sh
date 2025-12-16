#!/bin/bash
function f_add_network_manager() {
  if sudo grep -wq "renderer" "/etc/netplan/50-cloud-init.yaml"; then
      echo "- but NetworkManager as renderer is already being used;"
  else
      sudo echo -e "\trenderer: NetworkManager" >> /etc/netplan/50-cloud-init.yaml
  fi
}
