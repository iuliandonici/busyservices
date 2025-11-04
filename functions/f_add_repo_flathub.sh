#!/bin/bash
function f_add_repo_flathub() {
  # Installing using the official documentation
  source functions/f_check_networks.sh
  source functions/f_get_distro_id.sh
  # A variable to see what environment is currently installed
  var_f_add_repo_flathub_desktop=$(printf 'Desktop: %s' "$XDG_CURRENT_DESKTOP")
  if [[ $(f_get_distro_packager) == "apk" ]]; then
    if [[ $(f_check_networks) == "UP" ]]; then
      f_update_software
      if [[ "$EUID" -ne 0 ]]; then
        # Install the package
        doas apk add flatpak
        # Install the Software Flatpak plugin for KDE
        echo "- and we're using $var_f_add_repo_flathub_desktop;"
        echo "- currently installing the Software Flatpak plugin;"
        # if its' KDE
        if [[ $var_f_add_repo_flathub_desktop == "KDE" ]]; then
          doas apk add discover-backend-flatpak
        # or Gnome
        elif [[ $var_f_add_repo_flathub_desktop == "Gnome" ]]; then
          doas apk add gnome-software-plugin-flatpak
        fi
        # Add the Flathub repository
        echo "- currently adding the Flathub repository;"
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      else
        # Install the package
        apk add flatpak
        # Install the Software Flatpak plugin for KDE
        echo "- and we're using $var_f_add_repo_flathub_desktop;"
        echo "- currently installing the Software Flatpak plugin;"
          # if its' KDE
          if [[ $var_f_add_repo_flathub_desktop == "KDE" ]]; then
            apk add discover-backend-flatpak
          # or Gnome
          elif [[ $var_f_add_repo_flathub_desktop == "Gnome" ]]; then
            apk add gnome-software-plugin-flatpak
          fi
        # Add the Flathub repository
        echo "- currently adding the Flathub repository;"
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      fi
    else
      echo "- but we can't install Flatpak because the networks are down;"
    fi
  fi
}
