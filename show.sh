#!/bin/bash
function f_config_applet_temperature_indicator() {
# Install Linux Mint Cinammon's applet for showing CPU temperature
    wget https://cinnamon-spices.linuxmint.com/files/applets/temperature@fevimu.zip
    unzip *.zip
    mv temperature@fevimu/ ~/.local/share/cinammon/applets/
}
f_config_applet_temperature_indicator