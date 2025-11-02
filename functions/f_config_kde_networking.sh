#!/bin/bash
function f_config_kde_networking() {
    echo "- and currently configuring KDE networking;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ -f /etc/NetworkManager/NetworkManager.conf ]]; then
            echo "- but the NetworkManager.conf file already exists, so we're not going to configure the networking;"
        else
            if [[ "$EUID" -ne 0 ]]; then 
                sudo adduser $USER plugdev
                echo "[main] 
            dhcp=internal
            plugins=ifupdown,keyfile

            [ifupdown]
            managed=true

            [device]
            wifi.scan-rand-mac-address=yes
            wifi.backend=iwd
            wifi.iwd.autoconnect=yes" >> NetworkManager.conf
                sudo mv NetworkManager.conf /etc/NetworkManager/
                sudo mkdir -p /etc/NetworkManager/conf.d/
                echo "[main]
            auth-polkit=false" >> any-user.conf
                sudo mv any-user.conf /etc/NetworkManager/conf.d/
                sudo rc-service networking stop
                sudo rc-service wpa_supplicant stop
                sudo rc-service iwd start
                sudo rc-service networkmanager restart
                sudo rc-update add networkmanager default
                sudo rc-update del networking boot
                sudo rc-update del wpa_supplicant boot
            else
                adduser $USER plugdev
                echo "[main] 
            dhcp=internal
            plugins=ifupdown,keyfile

            [ifupdown]
            managed=true

            [device]
            wifi.scan-rand-mac-address=yes
            wifi.backend=iwd
            wifi.iwd.autoconnect=yes" >> NetworkManager.conf
                mv NetworkManager.conf /etc/NetworkManager/
                mkdir -p /etc/NetworkManager/conf.d/
                echo "[main]
            auth-polkit=false" >> any-user.conf
                mv any-user.conf /etc/NetworkManager/conf.d/
                rc-service networking stop
                rc-service wpa_supplicant stop
                rc-service iwd start
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
