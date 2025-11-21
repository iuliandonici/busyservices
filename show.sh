#!/bin/bash
function f_install_spotdl() {
  var_install_spotdl_software_array_alpine=("python3" "py3-pip" "pipx" "ffmpeg")
  var_install_spotdl_software_array_debian=("pip-check-reqs" "pipx" "python3-full" "ffmpeg")
  var_install_spotdl_host_ip=$(ip a | grep "inet 192.168.50" | awk '{print $2}' | sed 's/\/24//g')
  source functions/f_update_software.sh
  source functions/f_get_distro_packager.sh
  source functions/f_check_networks.sh
  echo " - and currently installing spotdl;"
  if [[ $(f_get_distro_packager) == "apk" ]]; then
    if [[ $(f_check_networks) == "UP" ]]; then
      echo "- here's a list of base software that will be installed using $(f_get_distro_packager):"
      for i in "${!var_install_spotdl_software_array_alpine[@]}"
      do
          echo " $i ${var_install_spotdl_software_array_alpine[$i]}"
      done
      f_update_software
      for i in "${!var_install_spotdl_software_array_alpine[@]}"
      do
        echo "- and currently installing: $i ${var_install_spotdl_software_array_alpine[$i]}"
        if [[ "$EUID" -ne 0 ]]; then 
          doas $(f_get_distro_packager) add ${var_install_spotdl_software_array_alpine[$i]}
        else
          $(f_get_distro_packager) add ${var_install_spotdl_software_array_alpine[$i]}
        fi
      done
      git clone git@github.com:spotDL/spotify-downloader.git ~/ 
      cd ~/spotify-downloader/
      pipx install spotdl
      pipx ensurepath
      mkdir ~/audio && cd ~/audio
      ~/.local/bin/spotdl web --host $var_install_spotdl_host_ip --keep-alive --web-use-output-dir
    else
      echo "- but can't install it because the networks are down;"
    fi
  elif [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
    if [[ $(f_check_networks) == "UP" ]]; then
      echo "- here's a list of base software that will be installed using $(f_get_distro_packager):"
      for i in "${!var_install_spotdl_software_array_debian[@]}"
      do
          echo " $i ${var_install_spotdl_software_array_debian[$i]}"
      done
      f_update_software
      for i in "${!var_install_spotdl_software_array_debian[@]}"
      do
        echo "- and currently installing: $i ${var_install_spotdl_software_array_debian[$i]}"
        if [[ "$EUID" -ne 0 ]]; then 
          sudo $(f_get_distro_packager) install -y ${var_install_spotdl_software_array_debian[$i]}
        else
          $(f_get_distro_packager) install -y ${var_install_spotdl_software_array_debian[$i]}
        fi
      done
      git clone git@github.com:spotDL/spotify-downloader.git ~/ 
      cd ~/spotify-downloader/
      pipx install spotdl
      pipx ensurepath
      mkdir ~/audio && cd ~/audio
      ~/.local/bin/spotdl web --host $var_install_spotdl_host_i --keep-alive --web-use-output-dir
    else
      echo "- but can't install it because the networks are down;"
    fi
  else
    echo "- but spotdl hasn't been tested on this distro;"
  fi
}
f_install_spotdl
