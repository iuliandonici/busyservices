#!/bin/bash
function f_config_kvm_images_ubuntu() {
    var_f_config_kvm_images_dir="/var/lib/libvirt/images"
    echo "- Downloading latest Ubuntu server ISO;"
    wget -q -X "*.10" http://cdimage.ubuntu.com/releases/ -O - | sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | grep '^[[:space:][:space:]][1-9]' | grep '.04.*' | sed 's/\///g' > ubuntuversions 
    cat ubuntuversions | sed 's/ //g' > ubuntu_last
    awk '{print $1 $2}' ubuntu_last | sort -nr | head -1 > latestubuntuversion
    # awk '{print $1 $2}' latestubuntuversion > lastubuntuversion
    # var_latest_ubuntu_version=$(cat lastubuntuversion)
    echo $var_latest_ubuntu_version
    # if ! [ -f $var_f_config_kvm_images_dir/ubuntu-$var_latest_ubuntu_version-live-server-amd64.iso ]; then
    # wget https://releases.ubuntu.com/${var_latest_ubuntu_version}/ubuntu-$var_latest_ubuntu_version-live-server-amd64.iso
    # sudo mv ubuntu*-live-server.iso $var_f_config_kvm_images_dir
    # else
    #     echo "- Latest Ubuntu server ($var_latest_ubuntu_version) ISO already exists in $var_f_config_kvm_images_dir/;"
    # fi
    # rm -rf ubuntuversions latestubuntuversion lastubuntuversion
}
f_config_kvm_images_ubuntu