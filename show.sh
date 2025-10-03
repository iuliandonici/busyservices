#!/bin/bash
function f_install_bluetooth() {
    sudo setup-devd udev
    sudo apk add bluez bluedevil bluetuith
    sudo modprobe btusb
    sudo adduser $USER lp
    sudo rc-service bluetooth start
    rc-update add bluetooth default
}
f_install_bluetooth