#!/bin/bash
function f_install_kde_themes() {
  doas mkdir -p ~/.local/share/plasma/desktoptheme/
  doas mkdir -p ~/.local/share/plasma/look-and-feel/
  doas mkdir -p ~/.local/share/color-schemes/
  git clone git@github.com:iuliandonici/busykdethemes.git
#  doas cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/desktoptheme/
#  doas cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/look-and-feel/
  doas cp -r busykdethemes/busytheme/Sweet-Ambar-Blue/ /usr/share/plasma/desktoptheme/
  doas cp -r busykdethemes/busytheme/Sweet-Ambar-Blue/ /usr/share/plasma/look-and-feel/ 
  doas cp -r busykdethemes/busytheme/SweetAmbarBlue.colors ~/.local/share/color-schemes/SweetAmbarBlue.colors
  doas cp -r busykdethemes/busytheme/candy-icons/ /usr/share/icons/
  doas cp -r busykdethemes/busytheme/Sweet-cursors/ /usr/share/icons/
  doas cp -r busykdethemes/busytheme/Sweet-Wallpapers/ /usr/share/wallpapers/
  doas cp -r busykdethemes/busytheme/Sweet/ /usr/share/sddm/themes/
}
