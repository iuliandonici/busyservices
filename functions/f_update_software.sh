#!/bin/bash
var_update_commands_array_debian=("update" "upgrade -y" "autoremove -y --purge")
var_update_commands_array_alpine=("update" "upgrade")
var_update_commands_array_alma=("update -y" "upgrade -y")
var_update_commands_array_opensuse=("refresh" "update -y" "clean")
echo "- Updating, upgrading and cleaning software:"
function f_update_software() {
    source functions/f_get_distro_packager.sh
    if [[ "$(f_get_distro_packager)" == "apk" ]]; then
        for i in "${!var_update_commands_array_alpine[@]}"
        do
            echo "- and currently running: $i ${var_update_commands_array_alpine[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) ${var_update_commands_array_alpine[$i]}  
            else
                $(f_get_distro_packager) ${var_update_commands_array_alpine[$i]}  
            fi
        done
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