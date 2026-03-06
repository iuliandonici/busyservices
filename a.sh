#!/bin/bash
function f_install_kde_themes() {
 mkdir -p ~/.local/share/plasma/desktoptheme/
 mkdir -p ~/.local/share/plasma/look-and-feel/
 cp -r busykdethemes/Sweet-Ambar-Blue/ ~/.local/share/plasma/desktoptheme/
 cp -r busykdethemes/busykdeplasmaplugin-sweet/ ~/.local/share/plasma/look-and-feel/
}
f_install_kde_themes
