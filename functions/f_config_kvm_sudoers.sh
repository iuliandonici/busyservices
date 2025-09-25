#!/bin/bash
function f_config_kvm_sudoers() {
    echo "- Adding current user to sudoers;"
    sudo echo "$USER ALL=(ALL:ALL) ALL" > /etc/sudoers
}