#!/bin/bash
function f_install_bluetooth() {
    sudo setup-devd udev
    sudo apk add bluez bluedevil bluetuith
    sudo modprobe btusb
    sudo adduser $USER lp
    sudo rc-service bluetooth start
    sudo rc-update add bluetooth default
    sudo sed -e "s/#Experimental = false/Experimental = true/g" -e "s/#AutoEnable=true/AutoEnable=false/g" -i /etc/bluetooth/main.conf
}
f_install_bluetooth