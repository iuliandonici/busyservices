#!/bin/bash
var_update_commands_array_debian=("update" "upgrade -y" "autoremove -y --purge")
var_update_commands_array_alpine=("update" "upgrade")
var_update_commands_array_alma=("update -y" "upgrade -y")
var_update_commands_array_opensuse=("refresh" "update -y" "clean")
function f_update_software() {
    source functions/f_get_distro_packager.sh
    source functions/f_check_networks.sh
    echo " - updating, upgrading and cleaning software;"
    if [[ "$(f_get_distro_packager)" == "apk" ]]; then
        if [[ $(f_check_networks) == "UP" ]]; then
            for i in "${!var_update_commands_array_alpine[@]}"
            do
                echo "- and currently running: $i ${var_update_commands_array_alpine[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) ${var_update_commands_array_alpine[$i]}  
                else
                    $(f_get_distro_packager) ${var_update_commands_array_alpine[$i]}  
                fi
            done
        else
            echo "- but can't update because the networks are down;"
        fi
    elif [[ "$(f_get_distro_packager)" == "dnf" ]]; then
        for i in "${!var_update_commands_array_alma[@]}"
        do
                echo "- and currently running: $i ${var_update_commands_array_alma[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) ${var_update_commands_array_alma[$i]}
                else
                    $(f_get_distro_packager) ${var_update_commands_array_alma[$i]}  
                fi
        done         
    elif [[ "$(f_get_distro_packager)" == "zypper" ]]; then
        for i in "${!var_update_commands_array_opensuse[@]}"
        do
                echo "- and currently running: $i ${var_update_commands_array_opensuse[$i]}"
                if [[ "$EUID" -ne 0 ]]; then 
                    sudo $(f_get_distro_packager) ${var_update_commands_array_opensuse[$i]}
                else
                    $(f_get_distro_packager) ${var_update_commands_array_opensuse[$i]}  
                fi
        done         
    else
        for i in "${!var_update_commands_array_debian[@]}"
        do
            echo "- and currently running: $i ${var_update_commands_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) ${var_update_commands_array_debian[$i]}
            else
                $(f_get_distro_packager) ${var_update_commands_array_debian[$i]}
            fi
        done
    fi
}
