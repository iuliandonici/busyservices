#!/bin/bash -i
function f_config_transmission_htpasswd () {
  echo " - and currently securing the service using htpasswd;"
  if [[ -f /usr/share/transmission/public_html/.htpasswd ]]; then
    echo " - but the service has already been secured;"
  else
    if [[ "$EUID" -ne 0 ]]; then
      sudo htpasswd -c /usr/share/transmission/public_html/.htpasswd $USER
    else
      htpasswd -c /usr/share/transmission/public_html/.htpasswd $USER
    fi
  fi
}

