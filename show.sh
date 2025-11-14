#!/bin/bash
function f_install_nginx() {
  source functions/f_update_software.sh
  source functions/f_get_distro_packager.sh
  source functions/f_check_networks.sh
  var_install_nginx_software_array=("nginx")
  if [[ $(f_get_distro_packager) == "apt" ]]; then
    echo "- and currently installing nginx;"
    if [[ $(f_check_networks) == "UP" ]]; then
      if [[ "$EUID" -ne 0 ]]; then 
          sudo $(f_get_distro_packager) install -y ${var_install_nginx_software_array[$i]}
      else
          $(f_get_distro_packager) install -y ${var_install_nginx_software_array[$i]}  
      fi
    else
      echo "- but can't install it because the networks are down;"
    fi
  fi
}
f_install_nginx

