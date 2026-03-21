#!/bin/bash
function f_install_kde_themes() {
  source functions/f_update_software.sh
  source functions/f_check_networks.sh
  source functions/f_get_security_utility.sh
  echo " - and currently installing KDE themes:"
  if [[ $(f_check_networks) == "UP" ]]; then
    if [[ "$EUID" -ne 0 ]]; then
      $(f_get_security_utility) rm -rf ~/.local/share/plasma/desktoptheme/busykdetheme-plasma/
      $(f_get_security_utility) rm -rf ~/.local/share/color-schemes/busykdetheme.colors
      $(f_get_security_utility) rm -rf ~/.local/share/sddm/themes/busykdetheme-sddm/
      $(f_get_security_utility) rm -rf ~/.local/share/icons/busykdetheme-icons/
      $(f_get_security_utility) rm -rf ~/.local/share/icons/busykdetheme-cursors/
      $(f_get_security_utility) rm -rf ~/.local/share/plasma/look-and-feel/busykdetheme-splash/
      mkdir -p ~/.local/share/plasma/desktoptheme/
      mkdir -p ~/.local/share/plasma/look-and-feel/
      # mkdir -p ~/.local/share/sddm/themes/
      mkdir -p ~/.local/share/color-schemes/
      mkdir -p ~/.local/share/icons/
      rm -rf busykdethemes/
      git clone git@github.com:iuliandonici/busykdethemes.git
      cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ ~/.local/share/plasma/desktoptheme/
      cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ ~/.local/share/plasma/look-and-feel/ 
      cp -r busykdethemes/busykdetheme/busykdetheme-global/ ~/.local/share/plasma/look-and-feel/
      cp -r busykdethemes/busykdetheme/busykdetheme-splash/ ~/.local/share/plasma/look-and-feel/
      cp -r busykdethemes/busykdetheme/busykdetheme.colors ~/.local/share/color-schemes/busykdetheme.colors
      cp -r busykdethemes/busykdetheme/busykdetheme-icons/ ~/.local/share/icons/
      cp -r busykdethemes/busykdetheme/busykdetheme-cursors/ ~/.local/share/icons/
      cp -r busykdethemes/busykdetheme/busykdetheme-wallpapers/ ~/.local/share/wallpapers/
      $(f_get_security_utility) cp -r busykdethemes/busykdetheme/busykdetheme-sddm/ /usr/share/sddm/themes/
      rm -rf busykdethemes/
    else
      rm -rf ~/.local/share/plasma/desktoptheme/busykdetheme-plasma/
      rm -rf ~/.local/share/color-schemes/busykdetheme.colors
      rm -rf ~/.local/share/sddm/themes/busykdetheme-sddm/
      rm -rf ~/.local/share/icons/busykdetheme-icons/
      rm -rf ~/.local/share/icons/busykdetheme-cursors/
      rm -rf ~/.local/share/plasma/look-and-feel/busykdetheme-splash/
      mkdir -p ~/.local/share/plasma/desktoptheme/
      mkdir -p ~/.local/share/plasma/look-and-feel/
      # mkdir -p ~/.local/share/sddm/themes/
      mkdir -p ~/.local/share/color-schemes/
      mkdir -p ~/.local/share/icons/
      rm -rf busykdethemes/
      git clone git@github.com:iuliandonici/busykdethemes.git
      cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ ~/.local/share/plasma/desktoptheme/
      cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ ~/.local/share/plasma/look-and-feel/ 
      cp -r busykdethemes/busykdetheme/busykdetheme-global/ ~/.local/share/plasma/look-and-feel/
      cp -r busykdethemes/busykdetheme/busykdetheme-splash/ ~/.local/share/plasma/look-and-feel/
      cp -r busykdethemes/busykdetheme/busykdetheme.colors ~/.local/share/color-schemes/busykdetheme.colors
      cp -r busykdethemes/busykdetheme/busykdetheme-icons/ ~/.local/share/icons/
      cp -r busykdethemes/busykdetheme/busykdetheme-cursors/ ~/.local/share/icons/
      cp -r busykdethemes/busykdetheme/busykdetheme-wallpapers/ ~/.local/share/wallpapers/
      cp -r busykdethemes/busykdetheme/busykdetheme-sddm/ /usr/share/sddm/themes/
      rm -rf busykdethemes/
    fi
  else
    echo "- but the networks are down so we can't install the KDE themes;"
  fi
}
