#!/bin/bash
# Installing 
function f_install_acf() {
  echo "- Currently setting up ACF (Alpine Configuration Framework):"
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
}
f_install_acf
