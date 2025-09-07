#!/bin/bashl
function f_config_kvm_images() {
    echo " - Getting ISO images for our KVM;"
    echo " - Getting latest ISO for Alpine Linux:"
    wget -r --no-parent -X "*/*/*/*/netboot*/" -A "alpine-standard-*.*.*-x86_64.iso" -R "alpine-standard-*.*.*_rc*-x86_64.iso" -N https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/
    # List the files in reverse order, remove all, except the 1st one
    var_images_folder="dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/"
    find $var_images_folder ! -name $(ls -h $var_images_folder | sort -nr | head -1) -type f -exec rm -f {} +
    # mkdir alpinelinux
    sudo mv $var_images_folder/*.iso .
    sudo cp -rf *.iso /var/lib/libvirt/images/
    rm -rf *.iso dl-cdn.alpinelinux.org/
}