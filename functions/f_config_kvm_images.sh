#!/bin/bashl
function f_config_kvm_images() {
    source functions/f_config_kvm_images_alpine.sh
    source functions/f_config_kvm_images_ubuntu.sh
    echo "- Getting latest ISO images for our KVM:"
    f_config_kvm_images_alpine
    f_config_kvm_images_ubuntu
}