#!/bin/bash
function f_update_flatpak() {
  var_update_commands_array_flatpak=("update -y" "uninstall -y --unused" "remove -y --delete-data" "repair")
  echo " - checking to see if Flatpak is installed;"  
  if [[ -f /usr/bin/flatpak ]]; then
    echo " - updating, autoremoving and repairing Flatpak apps;"    
    for i in "${!var_update_commands_array_flatpak[@]}"
    do
      echo "- and currently running: $i ${var_update_commands_array_flatpak[$i]}"
      flatpak ${var_update_commands_array_flatpak[$i]}  
    done
  else
    echo "- but Flatpak isn't installed on this system;"
  fi
}
