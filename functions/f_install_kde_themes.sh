#!/bin/bash
function f_install_kde_themes() {
  source functions/f_update_software.sh
echo " - and currently installing KDE themes:"
if [[ $(f_check_networks) == "UP" ]]; then
  if [[ "$EUID" -ne 0 ]]; then 
    $(f_get_security_utility) mkdir -p ~/.local/share/plasma/desktoptheme/
    $(f_get_security_utility) mkdir -p ~/.local/share/plasma/look-and-feel/
    $(f_get_security_utility) mkdir -p ~/.local/share/color-schemes/
    rm -rf busykdethemes/
    git clone git@github.com:iuliandonici/busykdethemes.git
    #  $(f_get_security_utility) cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/desktoptheme/
    #  $(f_get_security_utility) cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/look-and-feel/
    $(f_get_security_utility) cp -r busykdethemes/busytheme/Sweet-Ambar-Blue/ /usr/share/plasma/desktoptheme/
    $(f_get_security_utility) cp -r busykdethemes/busytheme/Sweet-Ambar-Blue/ /usr/share/plasma/look-and-feel/ 
    $(f_get_security_utility) cp -r busykdethemes/busytheme/SweetAmbarBlue.colors ~/.local/share/color-schemes/SweetAmbarBlue.colors
    $(f_get_security_utility) cp -r busykdethemes/busytheme/candy-icons/ /usr/share/icons/
    $(f_get_security_utility) cp -r busykdethemes/busytheme/Sweet-cursors/ /usr/share/icons/
    $(f_get_security_utility) cp -r busykdethemes/busytheme/Sweet-Wallpapers/ /usr/share/wallpapers/
    $(f_get_security_utility) cp -r busykdethemes/busytheme/Sweet-Ambar-Blue-Plasma-6/ /usr/share/sddm/themes/
    rm -rf busykdethemes/
  else
    mkdir -p ~/.local/share/plasma/desktoptheme/
    mkdir -p ~/.local/share/plasma/look-and-feel/
    mkdir -p ~/.local/share/color-schemes/
    rm -rf busykdethemes/
    git clone git@github.com:iuliandonici/busykdethemes.git
    #  cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/desktoptheme/
    #  cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/look-and-feel/
    cp -r busykdethemes/busytheme/Sweet-Ambar-Blue/ /usr/share/plasma/desktoptheme/
    cp -r busykdethemes/busytheme/Sweet-Ambar-Blue/ /usr/share/plasma/look-and-feel/ 
    cp -r busykdethemes/busytheme/SweetAmbarBlue.colors ~/.local/share/color-schemes/SweetAmbarBlue.colors
    cp -r busykdethemes/busytheme/candy-icons/ /usr/share/icons/
    cp -r busykdethemes/busytheme/Sweet-cursors/ /usr/share/icons/
    cp -r busykdethemes/busytheme/Sweet-Wallpapers/ /usr/share/wallpapers/
    cp -r busykdethemes/busytheme/Sweet-Ambar-Blue-Plasma-6/ /usr/share/sddm/themes/
    rm -rf busykdethemes/
  fi
else
  echo "- but the networks are down so we can't install the KDE themes;"
fi
}
