#!/bin/bash
shopt -s extglob
function f_config_applet_temperature_indicator() {
    if [[ -d ~/.local/share/cinnamon ]]; then
        rm -rf ~/.local/share/cinnamon/applets/temperature*/
        git clone git@github.com:linuxmint/cinnamon-spices-applets.git

        cd cinnamon-spices-applets/
        rm -rf $(ls -A | grep -v "temperature@fevimu")
        mv temperature@fevimu/files/temperature@fevimu ~/.local/share/cinnamon/applets/
        echo "- Temperature indicator applet has been installed."
        cd ../
        rm -rf cinnamon-spices-applets/
    else
        echo "There is no Cinnamon desktop for this function."
    fi
}