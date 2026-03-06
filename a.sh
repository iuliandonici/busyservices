#!/bin/bash
function f_install_kde_themes() {
 cp -r busykdeplasmatheme-sweet/ ~/.local/share/plasma/desktopthemes/
 cp -r busykdeplasmaplugin-sweet/ ~/.local/share/plasma/look-and-feel/
}
f_install_kde_themes
