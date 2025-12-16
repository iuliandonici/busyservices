#!/bin/bash
var_remove_cloud_init_software_array=("cloud-init")
var_remove_cloud_init_services_array=("systemd-networkd-wait-online")
function f_remove_cloud_init() {
  source functions/f_update_software.sh
  echo "- Currently removing cloud init and disabling systemd-networkd-wait-online service;"
  echo "- List of extra software that will be removed using $(f_get_distro_packager):"
  for i in "${!var_remove_cloud_init_software_array[@]}"
  do
      echo " $i ${var_remove_cloud_init_software_array[$i]}"
  done
  f_update_software
  for i in "${!var_install_server_prod_software_array[@]}"
  do
      echo "- currently removing: $i ${var_remove_cloud_init_software_array[$i]}"
      if [[ "$EUID" -ne 0 ]]; then 
          sudo $(f_get_distro_packager) remove -y ${var_install_server_prod_software_array[$i]} 
      else
          $(f_get_distro_packager) remove -y ${var_install_server_prod_software_array[$i]}  
      fi
  done


}
f_remove_cloud_init
