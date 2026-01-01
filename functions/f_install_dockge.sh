#!/bin/bash
function f_install_dockge() {
    source functions/f_get_distro_packager.sh
    echo "- Installing Dockge:"
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then
            echo "- and currently removing previous container:"
            doas docker container rm -f busydockge-container
            # Create directories that store your stacks and store Dockge's stack
            doas mkdir -p /home/busycontainers/busydockge-container/
            # Copy a default Dockge config
            doas cp -r functions/f_install_dockge.yaml /home/busycontainers/busydockge-container/compose.yaml
        else
            echo "- and currently removing previous container:"
            docker container rm -f busydockge-container
            # Create directories that store your stacks and store Dockge's stack
            mkdir -p /home/busycontainers/busydockge-container/
            # Copy a default Dockge config
            cp -r functions/f_install_dockge.yaml /home/busycontainers/busydockge-container/compose.yaml
        fi
        cd /home/busycontainers/busydockge-container/
        # Start the Server
        # docker compose up -d
        # If you are using docker-compose V1 or Podman
        echo "- composing the Dockge container:"
        docker-compose up -d
    elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        # Create directories that store your stacks and store Dockge's stack
        sudo mkdir -p /opt/busystacks /opt/busycontainers/bc-dockge
        # Copy a default Dockge config
        sudo cp -r functions/f_install_dockge.yaml /opt/busycontainers/bc-dockge/compose.yaml
        cd /opt/busycontainers/bc-dockge/
        # Start the Server
        # docker compose up -d
        # If you are using docker-compose V1 or Podman
        docker-compose up -d
    fi
}
