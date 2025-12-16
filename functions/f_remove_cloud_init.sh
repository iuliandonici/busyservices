#!/bin/bash
var_remove_cloud_init_software_array=("cloud-init")
function f_remove_cloud_init() {
  source functions/f_update_software.sh
  source functions/f_get_distro_packager.sh
  echo "- Currently removing cloud init;"
  echo "- List of extra software that will be removed using $(f_get_distro_packager):"
  for i in "${!var_remove_cloud_init_software_array[@]}"
  do
      echo " $i ${var_remove_cloud_init_software_array[$i]}"
  done
  if [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get"]]; then
    for i in "${!var_install_server_prod_software_array[@]}"
    do
        echo "- currently removing: $i ${var_remove_cloud_init_software_array[$i]}"
        if [[ "$EUID" -ne 0 ]]; then 
            sudo $(f_get_distro_packager) remove -y ${var_install_server_prod_software_array[$i]} 
        else
            $(f_get_distro_packager) remove -y ${var_install_server_prod_software_array[$i]}  
        fi
    done
  else
    echo "- but this function hasn't been tested on this os;"
  fi
}
