#!/bin/bash
function f_config_kvm_libirtd() {
    echo 'listen_tls = 0' >> /etc/libvirt/libvirtd.conf
    echo 'listen_tcp = 1' >> /etc/libvirt/libvirtd.conf
    echo 'tcp_port = "16509"' >> /etc/libvirt/libvirtd.conf
    echo 'listen_addr = "0.0.0.0"' >> /etc/libvirt/libvirtd.conf
    echo 'auth_tcp = "sasl"' >> /etc/libvirt/libvirtd.conf
}