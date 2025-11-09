#!/bin/bash
function f_install_bluetooth() {
    source functions/f_update_software.sh
    source functions/f_check_networks.sh
    var_install_bluetooth_software_array=("bluez" "bluedevil" "bluetuith" "blueman")
    var_install_bluetooth_name="$(hostname)-bt"
    echo " - and installing bluetooth;"
    echo "- here's a list of base software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_bluetooth_software_array[@]}"
    do
        echo " $i ${var_install_bluetooth_software_array[$i]}"
    done
    f_update_software
    if [[ $(f_check_networks) == "UP" ]]; then
        if [[ $(f_get_distro_packager) == "apk" ]]; then
            for i in "${!var_install_bluetooth_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_bluetooth_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    doas $(f_get_distro_packager) add ${var_install_bluetooth_software_array[$i]}
                    doas setup-devd udev
                    doas modprobe btusb
                    doas adduser $USER lp
                    doas rc-service bluetooth start
                    doas rc-update add bluetooth default
                    doas sed -e "s/#Experimental = false/Experimental = true/g" -e "s/#AutoEnable=true/AutoEnable=false/g" -e "s/#Name = BlueZ/Name = $var_install_bluetooth_name/g" -i /etc/bluetooth/main.conf
                else
                    $(f_get_distro_packager) add ${var_install_bluetooth_software_array[$i]}                
                    setup-devd udev
                    modprobe btusb
                    adduser $USER lp
                    rc-service bluetooth start
                    rc-update add bluetooth default
                    sed -e "s/#Experimental = false/Experimental = true/g" -e "s/#AutoEnable=true/AutoEnable=false/g" -e "s/#Name = BlueZ/Name = $var_install_bluetooth_name/g" -i /etc/bluetooth/main.conf
                fi
            done     
        elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
            for i in "${!var_install_bluetooth_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_bluetooth_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) install -y ${var_install_bluetooth_software_array[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_bluetooth_software_array[$i]}  
                fi
            done        
        else
            for i in "${!var_install_bluetooth_software_array[@]}"
            do
                echo "- and currently installing: $i ${var_install_bluetooth_software_array[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) install -y ${var_install_bluetooth_software_array[$i]}  
                else
                    $(f_get_distro_packager) install -y ${var_install_bluetooth_software_array[$i]}  
                fi
            done
        fi
    else
        echo "- but can't install them because the networks are down;"
    fi
}
