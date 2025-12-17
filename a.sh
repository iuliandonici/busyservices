#!/bin/bash
# Installing 
function f_install_acf() {
  echo "- Currently setting up ACF (Alpine Configuration Framework):"
  if [[ $(f_get_distro_packager) == "apk" ]]; then

    if [ -d /usr/share/acf ]; then
      echo "- but ACF is already installed;"
    else
      if [[ "$EUID" -ne 0 ]]; then 
        doas setup-acf
        doas acfpasswd -s root
      else
        setup-acf
        acfpasswd -s root
      fi
    fi
  else
    echo "- but this function hasn't been tested on this os;"
  fi
}
f_install_acf
