#!/bin/bash
function f_config_kvm_group() {
    sudo usermod -aG kvm,libvirt $USER
    newgrp libvirt    
}