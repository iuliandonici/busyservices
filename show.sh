#!/bin/bash
source functions/f_update_software.sh
f_update_software
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
echo "Docker is now installed!"
sudo systemctl stop docker.socket
sudo systemctl stop docker.service
sudo cp -r docker/install_server_docker.json /etc/docker/daemon.json
sudo systemctl start docker.socket
sudo systemctl start docker.service

sudo su - $USER








#!/bin/bash
source functions/f_get_distro_packager.sh
source functions/f_get_distro_id.sh
# source functions/f_install_base_software.sh
# source functions/f_install_extra_software.sh
function f_add_repo_docker() {
    echo "- Currently adding the VS Codium IDE repo using $(f_get_distro_packager)."
    if [[ "$(f_get_distro_packager)" == "dnf" ]]; then
        if [[ "$EUID" -ne 0 ]]; then # Setting a variable for getting the machine's architecture
            echo "- Adding the GPG key:"
            sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
              sudo mkdir -p /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
              echo \
                "deb [arch=$(dpkg --print-archi tecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            else
                echo "There is no version of VSCodium for x86."
            fi            
        else
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
              mkdir -p /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
            else
                echo "There is no VSCodium for this architecture."
            fi
        fi
    elif [[ "$(f_get_distro_packager)" == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then # Setting a variable for getting the machine's architecture
            echo "- Adding the GPG key:"
            sudo $(f_get_distro_packager) --gpg-auto-import-keys https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/zypp/repos.d/vscodium.repo
            else
                echo "There is no version of VSCodium for x86."
            fi            
        else
            echo "- Adding the GPG key:"
            $(f_get_distro_packager) --gpg-auto-import-keys https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
            
                printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | tee -a /etc/zypp/repos.d/vscodium.repo

            else
                echo "There is no VSCodium for this architecture."
            fi
        fi
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
                echo "There is no version of Docker for x86."
            fi            
        else
            wget https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
            -O /usr/share/keyrings/vscodium-archive-keyring.asc
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                echo 'deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.asc ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' \
                | tee /etc/apt/sources.list.d/vscodium.list
           else
                echo "There is no VSCodium for this architecture."
            fi
        fi
    fi
}
f_add_repo_docker