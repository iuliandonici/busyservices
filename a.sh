#!/bin/bash
function f_install_mate() {
      source functions/f_install_busychrome_audio.sh
      source functions/f_install_lite_xl.sh
      source functions/f_install_bluetooth.sh
      source functions/f_install_brave_browser.sh
      # f_install_kde_requirements

  doas setup-desktop mate
      f_install_busychrome_audio
      f_install_bluetooth
      f_install_lite_xl
      f_install_brave_browser

}
f_install_mate
