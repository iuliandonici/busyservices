#!/bin/bash
function f_config_xfce() {
    source functions/f_update_software.sh
    echo " - and currently configuring Xfce;"
    f_update_software
    if [[ $(f_check_networks) == "UP" ]]; then
        if [[ $(f_get_distro_packager) == "apk" ]]; then
            if [[ "$EUID" -ne 0 ]]; then
                $(f_get_security_utility) setup-xorg-base
                $(f_get_security_utility) rc-update add lightdm
                $(f_get_security_utility) rc-service lightdm restart                
                $(f_get_security_utility) echo '#!/sbin/openrc-run \ command="/usr/bin/startx"' > /etc/local.d/initx.start 
                $(f_get_security_utility) chown -R $USER:$USER /etc/local.d/initx.start
                $(f_get_security_utility) chmod +x /etc/local.d/initx.start
                # sudo f_install_busychrome_audio
            else
                setup-xorg-base
                rc-update add lightdm
                rc-service lightdm restart                
                echo '#!/sbin/openrc-run \ command="/usr/bin/startx"' > /etc/local.d/initx.start 
                chown -R $USER:$USER /etc/local.d/initx.start
                chmod +x /etc/local.d/initx.start
                # f_install_busychrome_audio
            fi
        elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
            echo "- No tests done for dns/zypper;"
        else
            echo "- No tests done for this distro;"
        fi
    else
        echo "- but can't configure KDE because the networks are down;"
    fi
}
