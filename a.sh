#!/bin/bash
function f_config_kvm_images_ubuntu() {
    var_f_config_kvm_images_dir="/var/lib/libvirt/images"
    echo "- then downloading latest Ubuntu server ISO:"
    wget -q -X "*.10" http://cdimage.ubuntu.com/releases/ -O - | sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | grep -E '^[[:space:][:space:]][1-9].*.04.*' | sed -e 's/\///g' -e 's/ //g' > ubuntu_last 
    grep -oE '^[12468]*.[0-10][02468]*.*' ubuntu_last | sort -nr | head -1 > laststableubuntuversion
    var_latest_ubuntu_version=$(cat laststableubuntuversion)
    if ! [ -f $var_f_config_kvm_images_dir/ubuntu-$var_latest_ubuntu_version-live-server-amd64.iso ]; then
        wget https://releases.ubuntu.com/${var_latest_ubuntu_version}/ubuntu-$var_latest_ubuntu_version-live-server-amd64.iso
        if [[ "$EUID" -ne 0 ]]; then 
            sudo rsync -aP --remove-source-files ubuntu-$var_latest_ubuntu_version-live-server-amd64.iso $var_f_config_kvm_images_dir
        else
            rsync -aP --remove-source-files ubuntu-$var_latest_ubuntu_version-live-server-amd64.iso $var_f_config_kvm_images_dir
        fi
    else
        echo "- but latest Ubuntu server ($var_latest_ubuntu_version) ISO already exists in $var_f_config_kvm_images_dir/;"
    fi
    # rm -rf ubuntu_last laststableubuntuversion
}
f_config_kvm_images_ubuntu
