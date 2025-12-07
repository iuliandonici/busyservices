#!/bin/bash
function f_config_transmission() {
    source functions/f_config_transmission_htpasswd.sh
    # Verify if Transmission has been installed
    if [[ -f /usr/bin/transmission-daemon ]]; then
        echo "- Transmission is installed, now we'll config it."
        if [[ "$EUID" -ne 0 ]]; then 
            sudo systemctl stop transmission-daemon.service
            sudo sed -i -e 's/Type=notify/Type=simple/g' /lib/systemd/system/transmission-daemon.service
            sudo cp -r functions/f_config_transmission.json settings.json
            sudo mv settings.json /var/lib/transmission-daemon/info/
            sudo usermod -a -G debian-transmission $USER
            sudo chmod 777 ~/
            sudo chown debian-transmission:debian-transmission /var/lib/transmission-daemon/info/settings.json
            f_config_transmission_htpasswd
            sudo systemctl start transmission-daemon.service
            sudo systemctl daemon-reload
        else
            systemctl stop transmission-daemon.service
            sed -i -e 's/Type=notify/Type=simple/g' /lib/systemd/system/transmission-daemon.service
            cp -r functions/f_config_transmission.json settings.json 
            mv settings.json /var/lib/transmission-daemon/info/
            usermod -a -G debian-transmission $USER
            chmod 777 ~/
            chown debian-transmission:debian-transmission /var/lib/transmission-daemon/info/settings.json
            f_config_transmission_htpasswd
            systemctl start transmission-daemon.service
            systemctl daemon-reload
        fi
    else
        echo "- Transmission isn't installed."
    fi
}
