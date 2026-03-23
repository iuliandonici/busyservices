#!/bin/bash
source functions/f_get_distro_id.sh
case $(f_get_distro_id) in
  ubuntu | debian | linuxmint | alpine | almalinux | fedora | opensuse-leap)
      echo "Initializing updates and installation of packages for $(f_get_distro_id)."
      # source functions/f_install_server_kvm_software.sh
      # f_install_server_kvm_software
      source functions/f_install_base_software.sh
      f_install_base_software
  ;;
  esac
case $(hostname) in
  busyalpines)
      echo "This is $(hostname)."
      source functions/f_install_gitea.sh
      f_install_gitea
  ;;
case $(hostname) in
  busychromebook)
      echo "This is $(hostname)."
      source functions/f_install_kde_requirements.sh
      source functions/f_install_kde_themes.sh
      source functions/f_install_busychrome_audio.sh
      source functions/f_install_lite_xl.sh
      source functions/f_install_bluetooth.sh
      source functions/f_install_brave_browser.sh
      f_install_kde_requirements
#      f_install_kde_themes 
      f_install_busychrome_audio
      f_install_bluetooth
      f_install_lite_xl
      f_install_brave_browser
      f_install_kde_themes
  ;;
  busycontainer)
    echo "This is $(hostname)."
    source functions/f_install_desktop_dev_software.sh
    f_install_desktop_dev_software
  ;;
busyubuntus)
    echo "This is $(hostname)."
    # source functions/f_install_jellyfin.sh
    # f_install_jellyfin
    source functions/f_install_xfce.sh
    f_install_xfce
  ;;

  busydocker)
    echo "This is $(hostname)."
    source functions/f_install_acf.sh
    source functions/f_install_docker.sh
    source functions/f_install_dockge.sh
#    f_install_acf
    f_install_docker
    f_install_dockge
  ;;
  busydev)
    echo "This is $(hostname)."
    source functions/f_install_server_dev_software.sh
    source functions/f_install_docker.sh
    source functions/f_install_dockge.sh
    # f_install_server_dev_software
    f_install_docker
    f_install_dockge
  ;;
  busyl)
    echo "This is $(hostname)."
    source functions/f_install_server_kvm_software.sh
    f_install_server_kvm_software
  ;;
  busyt | busyl)
    echo "This is $(hostname)."
    source functions/f_install_server_kvm_software.sh
    source functions/f_install_cockpit.sh
    source functions/f_install_brave_browser.sh
    f_install_server_kvm_software
    f_install_brave_browser
  ;;
  busycenter | busyubuntus)
    echo "This is $(hostname)."
    source functions/f_install_server_prod_software.sh
    f_install_server_prod_software
  ;;
esac
