function f_config_spotdl_htpasswd () {
  echo "- trying to secure the service using htpasswd;"
  if [[ -f $HOME/.config/spotdl/web-ui/dist/.htpasswd ]]; then
    echo " - but the service has already been secured;"
  else
    htpasswd -c $HOME/.config/spotdl/web-ui/dist/.htpasswd $USER
  fi
}
