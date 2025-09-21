#!/bin/bash
function f_config_kvm_sshd() {
    echo "- Removing, ccopying our own sshd config and restarting ssh;"
    sudo rm -rf /etc/ssh/sshd_config
    sudo cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
    sudo systemctl restart ssh
}