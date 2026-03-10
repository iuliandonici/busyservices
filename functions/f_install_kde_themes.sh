#!/bin/bash
function f_install_kde_themes() {
  source functions/f_update_software.sh
echo " - and currently installing KDE themes:"
if [[ $(f_check_networks) == "UP" ]]; then
  if [[ "$EUID" -ne 0 ]]; then
    $(f_get_security_utility) rm -rf ~/.local/share/plasma/ ~/.local/share/color-schemes/
    mkdir -p ~/.local/share/plasma/desktoptheme/
    mkdir -p ~/.local/share/plasma/look-and-feel/
    mkdir -p ~/.local/share/color-schemes/
    rm -rf busykdethemes/
    git clone git@github.com:iuliandonici/busykdethemes.git
    cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ ~/.local/share/plasma/desktoptheme/
    cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ ~/.local/share/plasma/look-and-feel/ 
    cp -r busykdethemes/busykdetheme/busykdeplugin-sweet/ ~/.local/share/share/plasma/look-and-feel/
    cp -r busykdethemes/busykdetheme/busykdetheme.colors /~/.local/share/share/color-schemes/busykdetheme.colors
    cp -r busykdethemes/busykdetheme/busykdetheme-icons/ ~/.local/share/icons/
    cp -r busykdethemes/busykdetheme/busykdetheme-cursors/ ~/.local/share/icons/
    cp -r busykdethemes/busykdetheme/busykdetheme-wallpapers/ ~/.local/share/wallpapers/
    cp -r busykdethemes/busykdetheme/busykdetheme-sddm/ ~/.local/share/sddm/themes/
    rm -rf busykdethemes/
  else
    mkdir -p /usr/share/plasma/desktoptheme/
    mkdir -p /usr/share/plasma/look-and-feel/
    mkdir -p /usr/share/color-schemes/
    rm -rf busykdethemes/
    git clone git@github.com:iuliandonici/busykdethemes.git
    cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ /usr/share/plasma/desktoptheme/
    cp -r busykdethemes/busykdetheme/busykdetheme-plasma/ /usr/share/plasma/look-and-feel/ 
    cp -r busykdethemes/busykdetheme/busykdeplugin-sweet/ /usr/share/share/plasma/look-and-feel/
    cp -r busykdethemes/busykdetheme/busykdetheme.colors /usr/share/share/color-schemes/busykdetheme.colors
    cp -r busykdethemes/busykdetheme/busykdetheme-icons/ /usr/share/icons/
    cp -r busykdethemes/busykdetheme/busykdetheme-cursors/ /usr/share/icons/
    cp -r busykdethemes/busykdetheme/busykdetheme-wallpapers/ /usr/share/wallpapers/
    cp -r busykdethemes/busykdetheme/busykdetheme-sddm/ /usr/share/sddm/themes/
    rm -rf busykdethemes/
  fi
else
  echo "- but the networks are down so we can't install the KDE themes;"
fi
}
