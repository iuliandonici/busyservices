#!/bin/bash
function f_install_kde_themes() {
  doas mkdir -p ~/.local/share/plasma/desktoptheme/
  doas mkdir -p ~/.local/share/plasma/look-and-feel/
  cd busytheme/
  doas  cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/desktoptheme/
  doas  cp -r Sweet-Ambar-Blue/ ~/.local/share/plasma/look-and-feel/
  doas  cp -r Sweet-Ambar-Blue/ /usr/share/plasma/desktoptheme/
  doas  cp -r Sweet-Ambar-Blue/ /usr/share/plasma/look-and-feel/ 
  doas cp -r SweetAmbarBlue.colors ~/.local/share/color-schemes/
  doas cp -r candy-icons/ /usr/share/icons/
  doas cp -r Sweet-cursors/ /usr/share/icons/
  doas cp -r Sweet-Wallpapers/ /usr/share/wallpapers/
  doas cp -r Sweet/ /usr/share/sddm/themes/
}
f_install_kde_themes
