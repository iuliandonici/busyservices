#!/bin/bash
var_install_docker_software_array_debian=("docker-ce" "docker-ce-cli" "containerd.io" "docker-compose-plugin")
var_install_docker_software_array_alpine=("docker" "docker-cli-compose" "containerd" )
function f_install_docker() {
    source functions/f_update_software.sh
    source functions/f_add_repo_docker.sh
    source functions/f_config_docker.sh
    f_update_software
    f_add_repo_docker
    f_update_software
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        echo "- List of extra software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_docker_software_array_alpine[@]}"
        do
            echo " $i ${var_install_docker_software_array_alpine[$i]}"
        done
        for i in "${!var_install_docker_software_array_alpine[@]}"
        do
            echo "- and currently installing: $i ${var_install_docker_software_array_alpine[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                doas $(f_get_distro_packager) add ${var_install_docker_software_array_alpine[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_docker_software_array_alpine[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_docker_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_docker_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_docker_software_array[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_docker_software_array[$i]}  
            fi
        done        
    elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        echo "- List of extra software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_docker_software_array_debian[@]}"
        do
            echo " $i ${var_install_docker_software_array_debian[$i]}"
        done
        for i in "${!var_install_docker_software_array_debian[@]}"
        do
            echo "- and currently installing: $i ${var_install_docker_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_docker_software_array_debian[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_docker_software_array_debian[$i]}  
            fi
        done
    else
        echo "- but this function hasn't been tested on this os;"
    fi
    f_update_software
    f_config_docker
}
