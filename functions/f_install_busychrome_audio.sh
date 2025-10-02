#!/bin/bash
function f_install_busychrome_audio() {
        git clone git@github.com:iuliandonici/busychrome-audio.git
        cd busychrome-audio/
        sudo ./setup-audio --force-avs-install
}