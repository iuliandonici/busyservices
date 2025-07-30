#!/bin/bash
function f_add_repo_vscodium() {
    echo "- Currently adding the VS Codium IDE repo using $(f_get_distro_packager):"
    if [[ "$(f_get_distro_packager)" == "dnf" ]]; then
         if [[ "$EUID" -ne 0 ]]; then        
            sudo $(f_get_distro_packager) install -y dnf-plugins-core
            sudo $(f_get_distro_packager) config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo curl -fsSLO "https://dl.brave.com/install.sh{,.asc}" && gpg --keyserver hkps://keys.openpgp.org --recv-keys D16166072CACDF2C9429CBF11BF41E37D039F691 && gpg --verify install.sh.asc
            $(f_get_distro_packager) config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        else
            $(f_get_distro_packager) install -y dnf-plugins-core
            curl -fsSLO "https://dl.brave.com/install.sh{,.asc}" && gpg --keyserver hkps://keys.openpgp.org --recv-keys D16166072CACDF2C9429CBF11BF41E37D039F691 && gpg --verify install.sh.asc
            $(f_get_distro_packager) config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        fi
    elif [[ "$(f_get_distro_packager)" == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo $(f_get_distro_packager) addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo $(f_get_distro_packager) rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        else
            $(f_get_distro_packager) addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        fi
    elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo wget https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
            -O /usr/share/keyrings/vscodium-archive-keyring.asc
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                echo 'deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.asc ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' \
                | sudo tee /etc/apt/sources.list.d/vscodium.list
            else
                echo "There is no version of VSCodium for x86."
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