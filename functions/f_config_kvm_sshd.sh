#!/bin/bash
function f_config_kvm_sshd() {
    echo "- Removing and copying our own sshd config;"
    sudo rm -rf /etc/ssh/sshd_config
    sudo cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
}