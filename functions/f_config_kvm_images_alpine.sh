#!/bin/bash
function f_config_kvm_images_alpine() {
    var_f_config_kvm_images_dir="/var/lib/libvirt/images"
    var_f_config_kvm_images_arch_alpine=("x86" "x86_64" "aarch64")
    var_f_config_kvm_images_repo_alpine="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases"
    var_f_config_kvm_images_repo_alpine_dir="dl-cdn.alpinelinux.org/alpine/latest-stable/releases"
    echo "- Downloading Alpine ISO for the following architectures:"
    for i in "${!var_f_config_kvm_images_arch_alpine[@]}"
    do
        echo " $i ${var_f_config_kvm_images_arch_alpine[$i]}"
    done
    echo "- Currently downloading Alpine ISOs for:"
    for i in "${!var_f_config_kvm_images_arch_alpine[@]}"
    do
        echo " $i ${var_f_config_kvm_images_arch_alpine[$i]}"
        # Getting a list of ISOs, filtering them and putting them into a file
        wget --no-parent $var_f_config_kvm_images_repo_alpine/${var_f_config_kvm_images_arch_alpine[$i]} -O - | grep -E "alpine-standard" | grep -Ev '_rc|asc|sha256|sha512' | sed -e 's/<[^>]*>//g' | awk '{print $1}' | sort -nr | head -1 > alpineversions
        echo $var_f_config_kvm_images_repo_alpine/${var_f_config_kvm_images_arch_alpine[$i]}/
        if ! [ -f $var_f_config_kvm_images_dir/$(cat alpineversions) ]; then
            wget -r -N $var_f_config_kvm_images_repo_alpine/${var_f_config_kvm_images_arch_alpine[$i]}/$(cat alpineversions)
            if [[ "$EUID" -ne 0 ]]; then 
                sudo rsync -aP --remove-source-files $var_f_config_kvm_images_repo_alpine_dir/${var_f_config_kvm_images_arch_alpine[$i]}/*.iso $var_f_config_kvm_images_dir
            else
                rsync -aP --remove-source-files $var_f_config_kvm_images_repo_alpine_dir/${var_f_config_kvm_images_arch_alpine[$i]}/*.iso $var_f_config_kvm_images_dir
            fi
        else
            echo "- but latest Alpine standard ($(cat alpineversions)) ISO already exists in $var_f_config_kvm_images_dir/;"
        fi
    done
    rm -rf alpineversions dl-cdn.*/
}
