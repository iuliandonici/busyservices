#!/bin/bash
function f_install_lite_xl() {
  source functions/f_check_networks.sh
  echo " - Installing code editor lite-xl:"
  if [[ $(f_check_networks) == "UP" ]]; then
    if [[ $(f_get_distro_packager) == "apk" ]]; then
      if [[ "$EUID" -ne 0 ]]; then
        if grep -wq "edge/testing" /etc/apk/repositories; then
          echo "- but the edge testing Alpine repository exists already;"
        else
          echo "- currently giving currrent user permissions to the Alpine Linux repositories file (/etc/apk/repositories);"
          sudo chown -R $USER:$USER /etc/apk/repositories
          echo "- currently adding the the edge testing Alpine repository;"
          sudo echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
        fi
        sudo apk update
        sudo apk add lite-xl
        echo "- currently adding the lite-xl plugin manager called lpm;"
        wget https://github.com/lite-xl/lite-xl-plugin-manager/releases/download/latest/lpm.`uname -m | sed 's/arm64/aarch64/'`-`uname | tr '[:upper:]' '[:lower:]'` -O lpm && chmod +x lpm
        ./lpm install plugin_manager --assume-yes
        sudo mv lpm /usr/bin/
        lpm plugin install --assume-yes autocomplete autosave editorconfig formatter gitstatus indentguide language_cmake language_containerfile language_htaccess language_sh language_csharp language_env language_fstab language_go language_ignore language_ini language_json language_nginx language_objc language_ssh_config language_yaml lsp plugin_manager restoretabs search_ui select_colorscheme selectionhighlight settings snippets tab_switcher
      else
        if grep -wq "edge/testing" /etc/apk/repositories; then
          echo "- but the edge testing Alpine repository exists already;"
        else
          echo "- currently giving currrent user permissions to the Alpine Linux repositories file (/etc/apk/repositories);"
          chown -R $USER:$USER /etc/apk/repositories
          echo "- currently adding the the edge testing Alpine repository;"
          echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
        fi
        apk update
        apk add lite-xl
        echo "- currently adding the lite-xl plugin manager called lpm;"
        wget https://github.com/lite-xl/lite-xl-plugin-manager/releases/download/latest/lpm.`uname -m | sed 's/arm64/aarch64/'`-`uname | tr '[:upper:]' '[:lower:]'` -O lpm && chmod +x lpm
        ./lpm install plugin_manager --assume-yes
        mv lpm /usr/bin/
        lpm plugin install --assume-yes autocomplete autosave editorconfig formatter gitstatus indentguide language_cmake language_containerfile language_htaccess language_sh language_csharp language_env language_fstab language_go language_ignore language_ini language_json language_nginx language_objc language_ssh_config language_yaml lsp plugin_manager restoretabs search_ui select_colorscheme selectionhighlight settings snippets tab_switcher --assume-yes
      fi
    else
      echo "- but lite-xl hasn't been tested on this distro;"
    fi
  else 
    echo "- but can't install lite-xl because the networks are down;"
  fi
}
