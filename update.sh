#!/bin/bash
source functions/f_get_distro_id.sh
source functions/f_install_base_software.sh
source functions/f_install_transmission_requirements.sh
source functions/f_config_transmission.sh
case $(f_get_distro_id) in
    ubuntu | debian | linuxmint | alpine | almalinux | fedora | opensuse-leap)
        echo "Initializing updates and installation of packages for $(f_get_distro_id)."
        f_install_base_software
    ;;
esac
case $(hostname) in
    busyt | mycontainer)
        echo "This is $(hostname)."
        source functions/f_install_desktop_dev_software.sh
        f_install_desktop_dev_software
    ;;
    busydev)
        echo "This is $(hostname)."
        source functions/f_install_server_dev_software.sh
        f_install_server_dev_software
        # ./docker/install_server_docker.sh
    ;;
    busycenter)
        echo "This is $(hostname)."
        f_install_transmission_requirements
        f_config_transmission
    ;;
esac