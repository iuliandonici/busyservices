#!/bin/bash
function f_config_kvm_sshd() {
    echo "- Removing, copying our own sshd config and restarting ssh;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo rm -rf /etc/ssh/sshd_config
            sudo cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
            sudo rc-service sshd restart
        else
            rm -rf /etc/ssh/sshd_config
            cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
            rc-service sshd restart
        fi
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
            sudo rm -rf /etc/ssh/sshd_config
            sudo cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
            sudo systemctl restart ssh
        else
            rm -rf /etc/ssh/sshd_config
            cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
            systemctl restart ssh
        fi
    else
        if [[ "$EUID" -ne 0 ]]; then 
            sudo rm -rf /etc/ssh/sshd_config
            sudo cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
            sudo systemctl restart ssh
        else
            rm -rf /etc/ssh/sshd_config
            cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
            systemctl restart ssh
        fi
    fi
}