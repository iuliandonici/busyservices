#!/bin/bash
function f_config_kde() {
    source functions/f_update_software.sh
    echo "- and currently configuring KDE;"
    f_update_software
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then
            doas setup-xorg-base
            doas rc-update add sddm
            # sudo f_install_busychrome_audio
        else
            setup-xorg-base
            rc-update add sddm
            # f_install_busychrome_audio
        fi
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        echo "- No tests done for dns/zypper;"
    else
        echo "- No tests done for this distro;"
    fi
}
