#!/bin/bash
function f_config_kvm_sshd() {
    sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo echo "PasswordAuthentification no"  >> /etc/ssh/sshd_config
    sudo echo "AuthentificationMethods publickey"  >> /etc/ssh/sshd_config
}