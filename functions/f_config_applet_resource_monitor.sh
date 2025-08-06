#!/bin/bash
function f_config_applet_resource_monitor() {
    mkdir Resource_Monitor@Ory0n
    cd Resource_Monitor@Ory0n/
    curl -s https://api.github.com/repos/0ry0n/Resource_Monitor/releases/latest \
    | grep "browser_download_url.*zip" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi -

    unzip *.zip
    rm -rf *.zip
    cd ../
    mv Resource_Monitor@Ory0n/ ~/.local/share/gnome-shell/extensions/
}