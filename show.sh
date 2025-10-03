#!/bin/bash
function f_install_bluetooth() {
    sudo setup-devd udev
    sudo apk add bluez bluedevil bluetuith
    sudo modprobe btusb
    sudo adduser $USER lp
    sudo rc-service bluetooth start
    sudo rc-update add bluetooth default
    var_install_bluetooth_name="$(hostname)-bt"
    sudo sed -e "s/#Experimental = false/Experimental = true/g" -e "s/#AutoEnable=true/AutoEnable=false/g" -e "s/#Name = BlueZ/Name = $var_install_bluetooth_name/g" -i /etc/bluetooth/main.conf
    
}
f_install_bluetooth