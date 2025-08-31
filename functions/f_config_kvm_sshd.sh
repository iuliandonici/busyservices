#!/bin/bash
function f_config_kvm_sshd() {
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    echo "PasswordAuthentification no"  >> /etc/ssh/sshd_config
    echo "AuthentificationMethods publickey"  >> /etc/ssh/sshd_config
}