#!/bin/bash
function f_add_repo_flathub() {
  # Installing using the official documentation
  source functions/f_check_networks.sh
  echo "- currently installing Flatkpak;"
  if [[ $(f_get_distro_packager) == "apk" ]]; then
    if [[ $(f_check_networks) == "UP" ]]; then
      if [[ "$EUID" -ne 0 ]]; then
        # Install the package
        doas apk add flatpak
        doas apk add discover-backend-flatpak
        # Install the Software Flatpak plugin for KDE
        doas apk add discover-backend-flatpak
        # Add the Flathub repository
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      else
        apk add flatpak
        apk add discover-backend-flatpak
        # Install the Software Flatpak plugin for KDE
        apk add discover-backend-flatpak
        # Add the Flathub repository
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      fi
    else
      echo "- but we can't install Flatpak because the networks are down;"
    fi
  fi
}
