#!/bin/bash
var_remove_packages_array=("cloud-init")
var_remove_packages_array_debian=("cloud-init")
function f_remove_packages() {
  source functions/f_update_software.sh
  f_update_software
  echo "- Currently removing software;"
  if [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
    echo "- List of extra software that will be removed using $(f_get_distro_packager):"
    for i in "${!var_remove_packages_array_debian[@]}"
    do
        echo " $i ${var_remove_packages_array_debian[$i]}"
    done
    for i in "${!var_remove_packages_array_debian[@]}"
    do
        echo "- currently removing: $i ${var_remove_packages_array_debian[$i]}"
        if [[ "$EUID" -ne 0 ]]; then 
            $(f_get_security_utility) $(f_get_distro_packager) remove -y ${var_remove_packages_array[$i]} 
        else
            $(f_get_distro_packager) remove -y ${var_remove_packages_array[$i]}  
        fi
    done
  else
    echo "- but this function hasn't been tested on this os;"
  fi
}
