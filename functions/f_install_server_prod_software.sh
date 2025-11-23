#!/bin/bash
var_install_server_prod_software_array=("docker-ce" "docker-ce-cli" "containerd.io" "docker-compose-plugin" "jellyfin")
function f_install_server_prod_software() {
    source functions/f_update_software.sh
    source functions/f_add_repo_docker.sh
    source functions/f_config_docker.sh
    source functions/f_add_repo_jellyfin.sh
    source functions/f_install_nginx_requirements.sh
    source functions/f_install_spotdl.sh
    source functions/f_install_transmission_requirements.sh
    f_update_software
    f_add_repo_docker
    f_update_software
    f_add_repo_jellyfin
    f_update_software
    echo "- List of extra software that will be installed using $(f_get_distro_packager):"
    for i in "${!var_install_server_prod_software_array[@]}"
    do
        echo " $i ${var_install_server_prod_software_array[$i]}"
    done
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        for i in "${!var_install_server_prod_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_server_prod_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) add ${var_install_server_prod_software_array[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_server_prod_software_array[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_server_prod_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_server_prod_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_server_prod_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_server_prod_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_server_prod_software_array[@]}"
        do
            echo "- Currently installing: $i ${var_install_server_prod_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_server_prod_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_server_prod_software_array[$i]}  
            fi
        done
    fi
    f_update_software
    f_config_docker
    f_update_software
    f_install_spotdl
    f_update_software
    f_install_nginx_requirements
    f_update_software
    f_install_transmission_requirements
    f_update_software
}
