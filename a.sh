#!/bin/bash
if grep -wq "renderer" "/etc/netplan/50-cloud-init.yaml"; then
    echo "- but NetworkManager as renderer is already being used;"
else
    echo -e "\t renderer: NetworkManager";
fi
