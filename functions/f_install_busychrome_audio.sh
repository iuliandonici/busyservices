#!/bin/bash
function f_install_busychrome_audio() {
        source functions/f_check_networks.sh
        echo " - and installing audio;"
        if [[ $(f_check_networks) == "UP" ]]; then
                git clone git@github.com:iuliandonici/busychrome-audio.git
                cd busychrome-audio
                ./setup-audio
                cd ../
                rm -rf busychrome-audio
        else
                echo "- but can't install it because the networks are down;"
        fi
}
