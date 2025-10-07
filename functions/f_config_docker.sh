#!/bin/bash
source functions/f_get_distro_packager.sh
source functions/f_get_distro_id.sh
function f_config_docker() {
    if [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                if [[ -f /usr/bin/docker ]]; then
                    echo "- Docker is installed. Now, we'll restart it."
                    sudo groupadd docker
                    sudo usermod -aG docker $USER
                    sudo systemctl stop docker.socket
                    sudo systemctl stop docker.service
                    sudo cp -r functions/f_config_docker.json /etc/docker/daemon.json
                    sudo systemctl start docker.socket
                    sudo systemctl start docker.service
                else 
                    echo "- Can't configure Docker because it's not installed:"
                    ls -alh /usr/bin/ | grep "docker"
                fi
            else
                echo "This isn't a functional architecture for this function."
            fi
        else
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                if [[ -f /usr/bin/docker ]]; then
                    echo "- Docker is installed. Now, we'll restart it."
                    groupadd docker
                    usermod -aG docker $USER
                    systemctl stop docker.socket
                    systemctl stop docker.service
                    cp -r functions/f_config_docker.json /etc/docker/daemon.json
                    systemctl start docker.socket
                    systemctl start docker.service
                else 
                    echo "- Can't configure Docker because it's not installed:"
                    ls -alh /usr/bin/ | grep "docker"
                fi
            else
                echo "This isn't a functional architecture for this function." 
            fi
        fi
    fi
}