#!/bin/bash
var_remove_packages_array=("cloud-init")
function f_remove_packages() {
  source functions/f_get_distro_packager.sh
  echo "- Currently removing software;"
  echo "- List of extra software that will be removed using $(f_get_distro_packager):"
  for i in "${!var_remove_packages_array[@]}"
  do
      echo " $i ${var_remove_packages_array[$i]}"
  done
  if [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
    for i in "${!var_remove_packages_array[@]}"
    do
        echo "- currently removing: $i ${var_remove_packages_array[$i]}"
        if [[ "$EUID" -ne 0 ]]; then 
            sudo $(f_get_distro_packager) remove -y ${var_remove_packages_array[$i]} 
        else
            $(f_get_distro_packager) remove -y ${var_remove_packages_array[$i]}  
        fi
    done
  else
    echo "- but this function hasn't been tested on this os;"
  fi
}
