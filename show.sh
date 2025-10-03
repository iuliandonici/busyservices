#!/bin/bash
function f_install_busychrome_audio() {
        echo "- and currently installing audio;"
        git clone git@github.com:iuliandonici/busychrome-audio.git
        cd busycrohome-audio
        sudo ./setup-audio
        cd ../
        rm -rf busychrome-audio
}
f_install_busychrome_audio