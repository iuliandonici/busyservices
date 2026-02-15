#!/bin/bash
var_install_jellyfin_software_array=("jellyfin" "jellyfin-web")
function f_install_jellyfin() {
    source functions/f_update_software.sh
    source functions/f_get_distro_packager.sh
    if [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        echo " - currently adding the repo and then installing Jellyfin using $(f_get_distro_packager):"
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
                echo "- and here's a list of software needed using $(f_get_distro_packager):"
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " $i ${var_install_jellyfin_software_array[$i]}"
                done
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " - currently installing: $i ${var_install_jellyfin_software_array[$i]}"
                    if [[ "$EUID" -ne 0 ]]; then 
                        sudo $(f_get_distro_packager) install -y ${var_install_jellyfin_software_array[$i]}  
                    else
                        $(f_get_distro_packager) install -y ${var_install_jellyfin_software_array[$i]}  
                    fi
                done
            else
                echo "- but here is no version of Jellyfin for this architecture ($architecture);"
            fi            
        else
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                mkdir /etc/apt/keyrings
                DISTRO="$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release )"
                CODENAME="$( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release )"
                curl -fsSL https://repo.jellyfin.org/${DISTRO}/jellyfin_team.gpg.key --no-check-certificate | gpg --batch --yes --dearmor -o /etc/apt/keyrings/jellyfin.gpg
                cat <<EOF | tee /etc/apt/sources.list.d/jellyfin.sources
Types: deb
URIs: https://repo.jellyfin.org/${DISTRO}
Suites: ${CODENAME}
Components: main
Architectures: $( dpkg --print-architecture )
Signed-By: /etc/apt/keyrings/jellyfin.gpg
EOF
                echo "- and here's a list of software needed using $(f_get_distro_packager):"
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " $i ${var_install_jellyfin_software_array[$i]}"
                done
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " - currently installing: $i ${var_install_jellyfin_software_array[$i]}"
                    if [[ "$EUID" -ne 0 ]]; then 
                        $(f_get_distro_packager) install -y ${var_install_jellyfin_software_array[$i]}  
                    else
                        $(f_get_distro_packager) install -y ${var_install_jellyfin_software_array[$i]}  
                    fi
                done
            else
                echo "- but here is no version of Jellyfin for this architecture ($architecture);"
            fi            
        fi
    elif [[ "$(f_get_distro_packager)" == "apk" ]]; then
        echo " - currently installing Jellyfin using $(f_get_distro_packager):"
        if [[ "$EUID" -ne 0 ]]; then 
            # Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                # echo "https://repo.jellyfin.org/alpine/latest" | doas tee -a /etc/apk/repositories
                # wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key --no-check-certificate | doas tee /etc/apk/keys/jellyfin_team.rsa.pub >/dev/null
                echo "- and here's a list of software needed using $(f_get_distro_packager):"
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " $i ${var_install_jellyfin_software_array[$i]}"
                done
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " - currently installing: $i ${var_install_jellyfin_software_array[$i]}"
                    if [[ "$EUID" -ne 0 ]]; then 
                        doas $(f_get_distro_packager) add ${var_install_jellyfin_software_array[$i]}
                        doas rc-update add ${var_install_jellyfin_software_array[0]} boot
                        doas sed -i 's/--nowebclient//' /etc/conf.d/jellyfin
                    else
                        $(f_get_distro_packager) add ${var_install_jellyfin_software_array[$i]}  
                        rc-update add ${var_install_jellyfin_software_array[0]} boot 
                        sed -i 's/--nowebclient//' /etc/conf.d/jellyfin
                    fi
                done
                f_update_software
            else
                echo "- but here is no version of Jellyfin for this architecture ($architecture);"
            fi            
        else
            # Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                # echo "https://repo.jellyfin.org/alpine/latest" | tee -a /etc/apk/repositories
                # wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key --no-check-certificate | tee /etc/apk/keys/jellyfin_team.rsa.pub >/dev/null
                echo "- and here's a list of software needed using $(f_get_distro_packager):"
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " $i ${var_install_jellyfin_software_array[$i]}"
                done
                for i in "${!var_install_jellyfin_software_array[@]}"
                do
                    echo " - currently installing: $i ${var_install_jellyfin_software_array[$i]}"
                    if [[ "$EUID" -ne 0 ]]; then 
                        doas $(f_get_distro_packager) add ${var_install_jellyfin_software_array[$i]}
                        doas rc-update add ${var_install_jellyfin_software_array[0]} boot 
                    else
                        $(f_get_distro_packager) add ${var_install_jellyfin_software_array[$i]}  
                        rc-update add ${var_install_jellyfin_software_array[0]} boot 
                    fi
                done
                f_update_software
            else
                echo "- but here is no version of Jellyfin for this architecture ($architecture);"
            fi            
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
f_install_jellyfin
