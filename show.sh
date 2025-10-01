#!/bin/bash
function f_install_kde() {
    sudo apk add setup-xorg-base plasma elogind polkit-elogind kde-applications font-terminus font-inconsolata font-dejavu font-noto font-noto-cjk font-awesome font-noto-extra font-liberation python3
    sudo rc-update add sddm
    git clone git@github.com:iuliandonici/busychrome-audio.git
    cd busychrome-audio/
    sudo ./setup-audio
    sudo reboot
}
f_install_kde