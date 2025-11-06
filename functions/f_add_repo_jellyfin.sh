#!/bin/bash
function f_add_repo_jellyfin() {
    source functions/f_update_software.sh
    echo "- Currently adding the Jellyfin repo using $(f_get_distro_packager)."
    if [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        if [[ "$( f_check_networks)" == "UP" ]]; then
            if [[ "$EUID" -ne 0 ]]; then 
                # Setting a variable for getting the machine's architecture
                architecture=$(uname -m)
                if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                    sudo mkdir /etc/apt/keyrings
                    DISTRO="$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release )"
                    CODENAME="$( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release )"
                    curl -fsSL https://repo.jellyfin.org/${DISTRO}/jellyfin_team.gpg.key | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/jellyfin.gpg
                    cat <<EOF | sudo tee /etc/apt/sources.list.d/jellyfin.sources
    Types: deb
    URIs: https://repo.jellyfin.org/${DISTRO}
    Suites: ${CODENAME}
    Components: main
    Architectures: $( dpkg --print-architecture )
    Signed-By: /etc/apt/keyrings/jellyfin.gpg
    EOF
                else
                    echo "- There is no version of Jellyfin for x86."
                fi            
            else
    # Setting a variable for getting the machine's architecture
                architecture=$(uname -m)
                if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                    mkdir /etc/apt/keyrings
                    DISTRO="$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release )"
                    CODENAME="$( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release )"
                    curl -fsSL https://repo.jellyfin.org/${DISTRO}/jellyfin_team.gpg.key | gpg --batch --yes --dearmor -o /etc/apt/keyrings/jellyfin.gpg
                    cat <<EOF | tee /etc/apt/sources.list.d/jellyfin.sources
    Types: deb
    URIs: https://repo.jellyfin.org/${DISTRO}
    Suites: ${CODENAME}
    Components: main
    Architectures: $( dpkg --print-architecture )
    Signed-By: /etc/apt/keyrings/jellyfin.gpg
    EOF
                else
                    echo "There is no Jellyfin version for this architecture."
                fi
            fi
            f_update_software
        else
            echo "- but can't install it because the networks are down;"
        fi
    fi
}
# sudo mkdir /etc/apt/keyrings
# DISTRO="$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release )"
# CODENAME="$( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release )"
# curl -fsSL https://repo.jellyfin.org/${DISTRO}/jellyfin_team.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/jellyfin.gpg
# cat <<EOF | sudo tee /etc/apt/sources.list.d/jellyfin.sources
# Types: deb
# URIs: https://repo.jellyfin.org/${DISTRO}
# Suites: ${CODENAME}
# Components: main
# Architectures: $( dpkg --print-architecture )
# Signed-By: /etc/apt/keyrings/jellyfin.gpg
# # EOF
# sudo apt update
# sudo apt install jellyfin -y
# sudo setfacl -R -m u:busyneo:rx /media/ssdextern/
