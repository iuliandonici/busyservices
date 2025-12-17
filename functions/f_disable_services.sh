#!/bin/bash
var_disable_services_array=("systemd-networkd-wait-online")
function f_disable_services() {
  echo "- List of extra services that will be disabled:"
  for i in "${!var_disable_services_array[@]}"
  do
      echo " $i ${var_disable_services_array[$i]}"
  done
  if [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
    for i in "${!var_disable_services_array[@]}"
    do
        echo "- currently disabling: $i ${var_disable_services_array[$i]}"
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
