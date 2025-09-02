#!/bin/bash
function f_config_kvm_group() {
    echo " - Creating users and groups for KVM;"
    sudo usermod -aG kvm,libvirt $USER
    sudo newgrp libvirt
}