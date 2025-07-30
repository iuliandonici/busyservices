#!/bin/bash
source functions/f_get_distro_packager.sh
function f_get_balenaetcher_deb() {
    echo "- Currently adding the Brave browser repo using $(f_get_distro_packager):"
    if [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                wget -O balena-etcher.deb -r --no-parent -A "balena-etcher_*.*.*_amd64.deb" https://github.com/balena-io/etcher/releases/
                sudo dpkg -i balena-etcher.deb && rm -rf balena-etcher.deb
            else
                wget -O balena-etcher.deb -r --no-parent -A "balena-etcher_*.*.*_amd64.deb" https://github.com/balena-io/etcher/releases/
                sudo dpkg -i balena-etcher.deb && rm -rf balena-etcher.deb
            fi            
        else
            echo "We're not there yet."
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                wget -O balena-etcher.deb -r --no-parent -A "balena-etcher_*.*.*_amd64.deb" https://github.com/balena-io/etcher/releases/
                dpkg -i balena-etcher.deb
            else
                wget -O balena-etcher.deb -r --no-parent -A "balena-etcher_*.*.*_amd64.deb" https://github.com/balena-io/etcher/releases/
                dpkg -i balena-etcher.deb 
            fi            
        fi
    fi
}
f_get_balenaetcher_deb