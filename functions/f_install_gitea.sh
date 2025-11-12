#!/bin/bash
function f_install_gitea() {
  var_install_gitea_software_array=("gitea" "mariadb" "mariadb-client")
  source functions/f_update_software.sh
  source functions/f_get_distro_packager.sh
  source functions/f_check_networks.sh
  echo " - installing Gitea;"
  if [[ $(f_get_distro_packager) == "apk" ]]; then
    if [[ $(f_check_networks) == "UP" ]]; then
      echo "- here's a list of base software that will be installed using $(f_get_distro_packager):"
      for i in "${!var_install_gitea_software_array[@]}"
      do
          echo " $i ${var_install_gitea_software_array[$i]}"
      done
      f_update_software
      for i in "${!var_install_gitea_software_array[@]}"
      do
        echo "- and currently installing: $i ${var_install_gitea_software_array[$i]}"
        if [[ "$EUID" -ne 0 ]]; then 
          doas $(f_get_distro_packager) add ${var_install_gitea_software_array[$i]}
        else
          $(f_get_distro_packager) add ${var_install_gitea_software_array[$i]}
        fi
      done
      if [[ "$EUID" -ne 0 ]]; then
        doas mariadb-install-db --user=mysql --datadir=/var/lib/mysql
        doas service mariadb start
        doas rc-update add mariadb
        doas mariadb-secure-installation
        mariadb -u root -p
        doas service gitea start
        doas rc-update add gitea
      else
        mariadb-install-db --user=mysql --datadir=/var/lib/mysql
        service mariadb start
        rc-update add mariadb
        mariadb-secure-installation
        mariadb -u root -p
        service gitea start
        rc-update add gitea
      fi 
    else
          echo "- but can't install them because the networks are down;"
    fi
  else 
    echo "- but Gitea wasn't tested on this distro;"
  fi
}
f_install_gitea
