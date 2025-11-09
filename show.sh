#!/bin/bash
function f_check_flatpak() {
  echo " - checking to see if Flatpak is installed;"
  if [[ -f /usr/bin/flatpak ]]; then
    echo " - updating Flatpak apps;"
    flatpak update -y
  else
    echo "- but Flatpak isn't installed on this system;"
  fi
}
f_check_flatpak
