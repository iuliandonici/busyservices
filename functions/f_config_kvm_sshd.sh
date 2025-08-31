#!/bin/bash
function f_config_kvm_sshd() {
    sudo rm -rf /etc/ssh/sshd_config
    sudo cp -r functions/f_config_kvm_sshd /etc/ssh/sshd_config
}