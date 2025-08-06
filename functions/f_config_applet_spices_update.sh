#!/bin/bash
shopt -s extglob
function f_config_applet_spices_update() {
    if [[ -d ~/.local/share/cinnamon ]]; then
        rm -rf ~/.local/share/cinnamon/applets/SpicesUpdate*/
        git clone git@github.com:linuxmint/cinnamon-spices-applets.git
        cd cinnamon-spices-applets/
        rm -rf $(ls -A | grep -v "SpicesUpdate")
        mv SpicesUpdate*/files/SpicesUpdate* ~/.local/share/cinnamon/applets/
        echo "- Spices update applet has been installed."
        cd ../
        rm -rf cinnamon-spices-applets/
    else
        echo "There is no Cinnamon desktop for this function."
    fi
}