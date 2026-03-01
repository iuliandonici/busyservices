#!/bin/bash
function f_config_xfce_networking() {
    source functions/f_get_security_utility.sh
    echo " - and currently configuring Xfce networking;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ -f /etc/NetworkManager/NetworkManager.conf ]]; then
            echo "- but the NetworkManager.conf file already exists, so we're not going to configure the networking;"
        else
            if [[ "$EUID" -ne 0 ]]; then
                $(f_get_security_utility) adduser $USER plugdev
                echo "[main]
            dhcp=internal
            plugins=ifupdown,keyfile

            [ifupdown]
            managed=true

            [device]
            wifi.scan-rand-mac-address=yes
            wifi.backend=wpa_supplicant
            wifi.wpa_supplicant.autoconnect=yes" >> NetworkManager.conf
                $(f_get_security_utility) mv NetworkManager.conf /etc/NetworkManager/
                $(f_get_security_utility) mkdir -p /etc/NetworkManager/conf.d/
                echo "[main]
            auth-polkit=false" >> any-user.conf
                $(f_get_security_utility) mv any-user.conf /etc/NetworkManager/conf.d/
                $(f_get_security_utility) rc-service networking stop
                $(f_get_security_utility) rc-service wpa_supplicant stop
                $(f_get_security_utility) rc-service networkmanager restart
                $(f_get_security_utility) rc-update add networkmanager default
                $(f_get_security_utility) rc-update del networking boot
                $(f_get_security_utility) rc-update del wpa_supplicant boot
            else
                adduser $USER plugdev
                echo "[main] 
            dhcp=internal
            plugins=ifupdown,keyfile

            [ifupdown]
            managed=true

            [device]
            wifi.scan-rand-mac-address=yes
            wifi.backend=wpa_supplicant
            wifi.wpa_supplicant.autoconnect=yes" >> NetworkManager.conf
                mv NetworkManager.conf /etc/NetworkManager/
                mkdir -p /etc/NetworkManager/conf.d/
                echo "[main]
            auth-polkit=false" >> any-user.conf
                mv any-user.conf /etc/NetworkManager/conf.d/
                rc-service networking stop
                rc-service wpa_supplicant stop
                rc-service networkmanager restart
                rc-update add networkmanager default
                rc-update del networking boot
                rc-update del wpa_supplicant boot
            fi
        fi
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then
            echo "- Nothing configured yet for dnf/zypper;"
        else
            echo "- Nothing configured yet as well for dnf/zypper;"
        fi
    else
        if [[ "$EUID" -ne 0 ]]; then
            echo "- Nothing configured for Debian just yet;"
        else
            echo "- Nothing configured for Debian just yet as well;"
        fi
    fi
}
