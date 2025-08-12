#!/bin/bash
var_install_transmission_requirements=("transmission-cli" "transmission-common" "transmission-daemon")
function f_install_transmission_requirements() {
    source functions/f_update_software.sh
    f_update_software
    echo "- List of base software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_transmission_requirements[@]}"
    do
        echo " $i ${var_install_transmission_requirements[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo "- Currently installing: $i ${var_install_transmission_requirements[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) add ${var_install_transmission_requirements[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_transmission_requirements[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo "- Currently installing: $i ${var_install_transmission_requirements[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            fi
        done        
    else
        for i in "${!var_install_transmission_requirements[@]}"
        do
            echo "- Currently installing: $i ${var_install_transmission_requirements[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_transmission_requirements[$i]}  
            fi
        done
    fi
    f_update_software
}
function f_config_transmission() {
    # Verify if Transmission has been installed
    if [[ -f /usr/bin/transmission-daemon ]]; then
        echo "- Transmission is installed, now we'll config it."
        if [[ "$EUID" -ne 0 ]]; then 
            sudo systemctl stop transmission-daemon.service
            sudo sed -i -e 's/Type=notify/Type=simple/g' /etc/systemd/system/transmission-daemon.service
            sudo cp -r functions/f_config_transmission.json settings.json
            sudo mv settings.json /var/lib/transmission-daemon/info/
            sudo usermod -a -G debian-transmission $USER
            sudo chown debian-transmission:debian-transmission /var/lib/transmission-daemon/info/settings.json
            sudo systemctl start transmission-daemon.service
        else
            systemctl stop transmission-daemon.service
            sed -i -e 's/Type=notify/Type=simple/g' /etc/systemd/system/transmission-daemon.service
            cp -r functions/f_config_transmission.json settings.json 
            mv settings.json /var/lib/transmission-daemon/info/
            usermod -a -G debian-transmission $USER
            chown debian-transmission:debian-transmission /var/lib/transmission-daemon/info/settings.json
            systemctl start transmission-daemon.service
        fi
    else
        echo "- Transmission isn't installed."
    fi
}
f_install_transmission_requirements
f_config_transmission