#!/bin/bash
function f_install_busychrome_audio() {
        echo "- and currently installing audio;"
        git clone git@github.com:iuliandonici/busychrome-audio.git
        ./busychrome-audio/setup-audio --force-avs-install
}