#!/bin/bash
function f_add_repo_docker() {
    source functions/f_check_networks.sh
    echo " - and currently adding the Docker repo using $(f_get_distro_packager):"
    if [[ "$(f_get_distro_packager)" == "apk" ]]; then
        echo "- but Docker on Alpine doesn't need repo adding;"
    elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc
              # Add the repository to Apt sources:
                echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            else
                echo "- but there is no version of Docker for x86;"
            fi            
        else
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                install -m 0755 -d /etc/apt/keyrings
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                chmod a+r /etc/apt/keyrings/docker.asc
                # Add the repository to Apt sources:
                echo \
                    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
                tee /etc/apt/sources.list.d/docker.list > /dev/null
            else
                echo "- but there is no Docker version for this architecture;"
            fi
        fi
    else
        echo "- but this function hasn't been tested on this os;"
    fi
}
