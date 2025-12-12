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
  busychromebook)
      echo "This is $(hostname)."
      source functions/f_install_kde_requirements.sh
      source functions/f_install_busychrome_audio.sh
      source functions/f_install_lite_xl.sh
      source functions/f_install_bluetooth.sh
      source functions/f_add_repo_brave_browser.sh
      f_install_kde_requirements
      f_install_busychrome_audio
      f_install_bluetooth
      f_install_lite_xl
      f_add_repo_brave_browser
  ;;
  busycontainer)
    echo "This is $(hostname)."
    source functions/f_install_desktop_dev_software.sh
    f_install_desktop_dev_software
  ;;
  busydev)
    echo "This is $(hostname)."
    source functions/f_install_server_dev_software.sh
    f_install_server_dev_software
  ;;
  busyt | busyl)
    echo "This is $(hostname)."
    source functions/f_install_server_kvm_software.sh
    source functions/f_install_cockpit.sh
    f_install_server_kvm_software
  ;;
  busycenter | busyubuntus)
    echo "This is $(hostname)."
    source functions/f_install_server_prod_software.sh
    f_install_server_prod_software
  ;;
esac
