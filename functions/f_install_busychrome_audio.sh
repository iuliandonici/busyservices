#!/bin/bash
function f_install_busychrome_audio() {
        echo "- and currently installing audio;"
        git clone git@github.com:iuliandonici/busychrome-audio.git
        sudo ./busychrome-audio/setup-audio
        rm -rf busychrome-audio
}