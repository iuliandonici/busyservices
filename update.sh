#!/bin/bash
source functions/f_get_distro_id.sh
source functions/f_install_base_software.sh
source functions/f_install_extra_software.sh
case $(f_get_distro_id) in
    ubuntu | debian | linuxmint | alpine | almalinux | fedora | opensuse-leap)
        echo "Initializing updates and installation of packages for $(f_get_distro_id)."
        f_install_base_software
        ./git/configure_git.sh
    ;;
esac
case $(hostname) in
    busyt | mycontainer)
        echo "This is $(hostname)"
        # f_install_extra_software
        f_install_extra_software
    ;;
    busydev)
        # ./docker/install_server_docker.sh
        f_add_repo_docker
        f_update_software
    ;;
esac