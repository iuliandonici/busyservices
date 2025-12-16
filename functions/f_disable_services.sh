#!/bin/bash
var_disable_services_array=("systemd-networkd-wait-online")
function f_disable_services() {
  echo "- Currently removing the ${var_disable_services_array[$i]} service;"
  if [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
    for i in "${!var_disable_services_array[@]}"
    do
        echo "- currently removing: $i ${var_disable_services_array[$i]}"
        if [[ "$EUID" -ne 0 ]]; then 
          sudo systemctl disable ${var_disable_services_array[$i]}.service 
        else
          systemctl disable ${var_disable_services_array[$i]}.service 
        fi
    done
  else
    echo "- but this function hasn't been tested on this os;"
  fi
}
