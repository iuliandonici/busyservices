#!/bin/bash
function f_add_repo_brave_browser() {
    source functions/f_update_software.sh
    source functions/f_add_repo_flathub.sh
    echo " - and currently adding the Brave browser repo using $(f_get_distro_packager):"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ $(f_check_networks) == "UP" ]]; then
            echo "- but Brave browser isn't available on $(f_get_distro_id) using the $(f_get_distro_packager) packager so instead we're using flatpak;"
            f_add_repo_flathub
            flatpak install -y flathub com.brave.Browser
            f_update_software
        else
            echo "- but we can't install Brave browser because the networks are down;"
        fi
    elif [[ "$(f_get_distro_packager)" == "dnf" ]]; then
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
        if [[ $(f_check_networks) == "UP" ]]; then
            if [[ "$EUID" -ne 0 ]]; then 
                sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
                # Setting a variable for getting the machine's architecture
                architecture=$(uname -m)
                if [[ $architecture=="x64" || $architecture=="x86_64" ]]; then
                    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
                else
                    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
                fi            
            else
                curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
                # Setting a variable for getting the machine's architecture
                architecture=$(uname -m)
                if [[ $architecture=="x64" || $architecture=="x86_64" ]]; then
                    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list
                else
                    echo "deb [signed-by=/usr/share/eyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list
                fi
            fi
        else
            echo "- but we can't install Brave browser because the networks are down;"
        fi
    fi
}
