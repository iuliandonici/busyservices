#!/bin/bash
function f_config_kvm_images_alpine() {
    var_f_config_kvm_images_arch_alpine=("x86" "x86_64" "aarch64")
    var_f_config_kvm_images_repo_alpine="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases"
    var_f_config_kvm_images_repo_alpine_dir="dl-cdn.alpinelinux.org/alpine/latest-stable/releases"
    echo " - Downloading Alpine ISO for the following architectures:"
    for i in "${!var_f_config_kvm_images_arch_alpine[@]}"
    do
        echo " $i ${var_f_config_kvm_images_arch_alpine[$i]}"
    done
    echo " - Currently downloading Alpine ISOs for:"
    for i in "${!var_f_config_kvm_images_arch_alpine[@]}"
    do
        echo " $i ${var_f_config_kvm_images_arch_alpine[$i]}"
        wget -r --no-parent -X "*/*/*/*/netboot*/" -A "alpine-standard-*.*.*-${var_f_config_kvm_images_arch_alpine[$i]}.iso" -R "alpine-standard-*.*.*_rc*-${var_f_config_kvm_images_arch_alpine[$i]}.iso" -N $var_f_config_kvm_images_repo_alpine/${var_f_config_kvm_images_arch_alpine[$i]}
        echo "$var_f_config_kvm_images_repo_alpine/${var_f_config_kvm_images_arch_alpine[$i]}"
    done
    echo " - Getting rid of previous images for:"
    for i in "${!var_f_config_kvm_images_arch_alpine[@]}"
    do
        echo " $i ${var_f_config_kvm_images_arch_alpine[$i]}"
        find $var_f_config_kvm_images_repo_alpine_dir/${var_f_config_kvm_images_arch_alpine[$i]} ! -name $(ls -h $var_f_config_kvm_images_repo_alpine_dir/${var_f_config_kvm_images_arch_alpine[$i]} | sort -nr | head -1) -type f -exec rm -f {} +
    done
    echo " - Moving all ISOs into current folder;"
    for i in "${!var_f_config_kvm_images_arch_alpine[@]}"
    do
        echo " - moving images for architecture:"
        echo " $i ${var_f_config_kvm_images_arch_alpine[$i]}"
        mv  $var_f_config_kvm_images_repo_alpine_dir/${var_f_config_kvm_images_arch_alpine[$i]}/*.iso .
    done
    echo " - Copying the images fronm current folder to the official images repo;"
    sudo cp -r *.iso /var/lib/libvirt/images/
    echo " - Removing unwanted folders and leftover images;"
    rm -rf *.iso dl-cdn.alpinelinux.org/
}
