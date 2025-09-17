#!/bin/bash
shopt -s extglob
function f_config_applet_multicore_system_monitor() {
    if [[ -d ~/.local/share/cinnamon ]]; then
        rm -rf ~/.local/share/cinnamon/applets/multicore-sys*/
        git clone git@github.com:linuxmint/cinnamon-spices-applets.git
        cd cinnamon-spices-applets/
        rm -rf $(ls -A | grep -v "multicore-sys")
        mv multicore-sys*/files/multicore-sys* ~/.local/share/cinnamon/applets/
        echo "- Multicore system monitor applet has been installed."
        cd ../
        rm -rf cinnamon-spices-applets/
    else
        echo "There is no Cinnamon desktop for this function."
    fi
}