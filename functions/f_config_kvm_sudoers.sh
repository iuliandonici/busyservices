#!/bin/bash
function f_config_kvm_sudoers() {
    echo "- Adding current user to sudoers;"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        sudo echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers
        sudo sed -i 's/#%sudo/%sudo/g/' /etc/sudoers/
    else
        echo "$USER ALL=(ALL:ALL) ALL" > /etc/sudoers    
    fi
}