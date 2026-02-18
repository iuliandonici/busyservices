#!/bin/bash
function f_config_transmission() {
    # Verify if Transmission has been installed
    if [[ -f /usr/bin/transmission-daemon ]]; then
        echo "- Transmission is installed, now we'll config it:"
        if [[ $(f_get_distro_packager) == "apk" ]]; then
            if [[ "$EUID" -ne 0 ]]; then 
                doas rc-service transmission-daemon stop
                doas cp -r functions/f_config_transmission.json settings.json
                doas mv settings.json /var/lib/transmission/config/settings.json
                doas addgroup root transmission
                doas mkdir /var/downloads/
                doas chown -R transmission:transmission /var/downloads/
                doas rc-update add transmission-daemon
                # doas lbu commit device
                doas rc-service transmission-daemon restart
            else
                rc-service transmission-daemon stop
                cp -r functions/f_config_transmission.json settings.json
                mv settings.json /var/lib/transmission/config/settings.json
                addgroup root transmission
                mkdir /var/downloads/
                chown -R transmission:transmission /var/downloads/
                rc-update add transmission-daemon
                # lbu commit device
                rc-service transmission-daemon restart
            fi
        elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
            if [[ "$EUID" -ne 0 ]]; then 
                sudo systemctl stop transmission-daemon.service
                # sudo sed -i -e 's/Type=notify/Type=simple/g' /etc/systemd/system/transmission-daemon.service
                sudo sed -i -e 's/Type=notify/Type=simple/g' /lib/systemd/system/transmission-daemon.service
                sudo cp -r functions/f_config_transmission.json settings.json
                sudo mv settings.json /var/lib/transmission-daemon/info/
                sudo usermod -a -G debian-transmission $USER
                sudo chmod 777 ~/
                sudo chown debian-transmission:debian-transmission /var/lib/transmission-daemon/info/settings.json
                sudo systemctl restart transmission-daemon.service
                sudo systemctl daemon-reload
            else
                systemctl stop transmission-daemon.service
                # sed -i -e 's/Type=notify/Type=simple/g' /etc/systemd/system/transmission-daemon.service
                sed -i -e 's/Type=notify/Type=simple/g' /lib/systemd/system/transmission-daemon.service
                cp -r functions/f_config_transmission.json settings.json 
                mv settings.json /var/lib/transmission-daemon/info/
                usermod -a -G debian-transmission $USER
                chmod 777 ~/
                chown debian-transmission:debian-transmission /var/lib/transmission-daemon/info/settings.json
                systemctl restart transmission-daemon.service
                systemctl daemon-reload
            fi
        fi
    else
        echo "- Transmission isn't installed."
    fi
}
