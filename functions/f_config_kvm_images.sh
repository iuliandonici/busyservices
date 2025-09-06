#!/bin/bashl
function f_config_kvm_images() {
    echo " - Getiing ISO images for our KVM;"
    echo " - Latest ISO images for Alpine Linux:"
    wget -r --no-parent -A 'alpine-standard-*.*.*-x86_64.iso' https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/ && rm -rf dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/alpine-standard-*.*.*_rc*-x86_64.iso dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/netboot*
    sudo mv dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/*.iso /var/lib/libvirt/images/
}