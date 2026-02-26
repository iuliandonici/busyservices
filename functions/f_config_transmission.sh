#!/bin/bash
function f_config_transmission() {
    source functions/f_get_security_utility.sh
    # Verify if Transmission has been installed
    if [[ -f /usr/bin/transmission-daemon ]]; then
        echo "- Transmission is installed, now we'll config it:"
        if [[ $(f_get_distro_packager) == "apk" ]]; then
            if [[ "$EUID" -ne 0 ]]; then 
                $(f_get_security_utility) rc-service transmission-daemon stop
                $(f_get_security_utility) cp -r functions/f_config_transmission.json settings.json
                $(f_get_security_utility) mv settings.json /var/lib/transmission/config/settings.json
                $(f_get_security_utility) addgroup root transmission
                $(f_get_security_utility) mkdir /var/downloads/
                $(f_get_security_utility) chown -R transmission:transmission /var/downloads/
                $(f_get_security_utility) rc-update add transmission-daemon
                # $(f_get_security_utility) lbu commit device
                $(f_get_security_utility) rc-service transmission-daemon restart
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
                $(f_get_security_utility) systemctl stop transmission-daemon.service
                # $(f_get_security_utility) sed -i -e 's/Type=notify/Type=simple/g' /etc/systemd/system/transmission-daemon.service
                $(f_get_security_utility) sed -i -e 's/Type=notify/Type=simple/g' /lib/systemd/system/transmission-daemon.service
                $(f_get_security_utility) cp -r functions/f_config_transmission.json settings.json
                $(f_get_security_utility) mv settings.json /var/lib/transmission-daemon/info/
                $(f_get_security_utility) usermod -a -G debian-transmission $USER
                $(f_get_security_utility) chmod 777 ~/
                $(f_get_security_utility) chown debian-transmission:debian-transmission /var/lib/transmission-daemon/info/settings.json
                $(f_get_security_utility) systemctl restart transmission-daemon.service
                $(f_get_security_utility) systemctl daemon-reload
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
