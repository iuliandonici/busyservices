#!/bin/bash
# source functions/f_update_software.sh
# f_update_software
# sudo mkdir -p /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
# sudo groupadd docker
# sudo usermod -aG docker $USER
# echo "Docker is now installed!"
# sudo systemctl stop docker.socket
# sudo systemctl stop docker.service
# sudo cp -r docker/install_server_docker.json /etc/docker/daemon.json
# sudo systemctl start docker.socket
# sudo systemctl start docker.service

# sudo su - $USER




function f_config_docker() {
    if [[ -f /usr/bin/docker ]]; then
        echo "- Docker is installed. Now, we'll restart it."
        sudo groupadd docker
        sudo usermod -aG docker $USER
        sudo systemctl stop docker.socket
        sudo systemctl stop docker.service
        sudo cp -r docker/install_server_docker.json /etc/docker/daemon.json
        sudo systemctl start docker.socket
        sudo systemctl start docker.service
        echo "- Status Docker:"
        sudo systemctl status docker.service
        sudo su - $USER
    else 
        echo "- Can't configure Docker because it's not installed."
    fi
}



source functions/f_get_distro_packager.sh
source functions/f_get_distro_id.sh
# source functions/f_install_base_software.sh
# source functions/f_install_extra_software.sh
function f_add_repo_docker() {
    echo "- Currently adding the Docker repo using $(f_get_distro_packager)."
    if [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
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
                echo "- There is no version of Docker for x86."
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
                echo "There is no Docker version for this architecture."
            fi
        fi
    fi
}
f_add_repo_docker
f_config_docker