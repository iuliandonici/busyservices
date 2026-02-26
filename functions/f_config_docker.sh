#!/bin/bash
function f_config_docker() {
    source functions/f_get_distro_packager.sh
    source functions/f_get_distro_id.sh
    source functions/f_get_security_utility.sh
    echo "- and currently configuring Docker;"
    if [[ "$(f_get_distro_packager)" == "apk" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                if [[ -f /usr/bin/docker ]]; then
                    echo "- and Docker is installed; now, we'll restart it;"
                    $(f_get_security_utility) addgroup ${USER} docker
                    $(f_get_security_utility) rc-update add docker boot
                    $(f_get_security_utility) rc-update add docker default
                    $(f_get_security_utility) rc-service docker stop
                    $(f_get_security_utility) mkdir /etc/docker/
                    $(f_get_security_utility) cp -r functions/f_config_docker.json /etc/docker/daemon.json
                    $(f_get_security_utility) rc-service docker start
                    echo "- sleeping for 5s do we can give a chance the Docker daemon to reload;"
                    sleep 5
                else 
                    echo "- but can't configure Docker because it's not installed:"
                    ls -alh /usr/bin/ | grep "docker"
                fi
            else
                echo "- but this isn't a functional architecture for this function;"
            fi
        else
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                if [[ -f /usr/bin/docker ]]; then
                    echo "- but Docker is installed; now, we'll restart it;"
                    addgroup ${USER} docker
                    rc-update add docker boot
                    rc-update add docker default
                    rc-service docker stop
                    mkdir /etc/docker/   
                    cp -r functions/f_config_docker.json /etc/docker/daemon.json
                    rc-service docker start
                    echo "- sleeping for 5s do we can give a chance the Docker daemon to reload;"
                    sleep 5
                else 
                    echo "- but can't configure Docker because it's not installed:"
                    ls -alh /usr/bin/ | grep "docker"
                fi
            else
                echo "- but this isn't a functional architecture for this function." 
            fi
        fi
    elif [[ "$(f_get_distro_packager)" == "apt" || "$(f_get_distro_packager)" == "apt-get" ]]; then
        if [[ "$EUID" -ne 0 ]]; then 
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                if [[ -f /usr/bin/docker ]]; then
                    echo "- and Docker is installed; now, we'll restart it;"
                    $(f_get_security_utility) groupadd docker
                    $(f_get_security_utility) usermod -aG docker $USER
                    $(f_get_security_utility) systemctl stop docker.socket
                    $(f_get_security_utility) systemctl stop docker.service
                    # And because on systemd, Docker already starts with the -H flah, we have to override it (https://stackoverflow.com/questions/44052054/unable-to-start-docker-after-configuring-hosts-in-daemon-json)
                    $(f_get_security_utility) cp -r /lib/systemd/system/docker.service /etc/systemd/system/
                    $(f_get_security_utility) sed -i 's/\ -H\ fd:\/\///g' /etc/systemd/system/docker.service
                    $(f_get_security_utility) cp -r functions/f_config_docker.json /etc/docker/daemon.json
                    $(f_get_security_utility) systemctl start docker.socket
                    $(f_get_security_utility) systemctl daemon-reload
                    $(f_get_security_utility) systemctl start docker.service
                    echo "- sleeping for 5s do we can give a chance the Docker daemon to reload;"
                    sleep 5
                else 
                    echo "- but can't configure Docker because it's not installed:"
                    ls -alh /usr/bin/ | grep "docker"
                fi
            else
                echo "- but this isn't a functional architecture for this function;"
            fi
        else
# Setting a variable for getting the machine's architecture
            architecture=$(uname -m)
            if [[ $architecture == "x64" || $architecture == "x86_64" ]]; then
                if [[ -f /usr/bin/docker ]]; then
                    echo "- but Docker is installed; now, we'll restart it;"
                    groupadd docker
                    usermod -aG docker $USER
                    systemctl stop docker.socket
                    systemctl stop docker.service
                    # And because on systemd, Docker already starts with the -H flah, we have to override it (https://stackoverflow.com/questions/44052054/unable-to-start-docker-after-configuring-hosts-in-daemon-json)
                    cp -r /lib/systemd/system/docker.service /etc/systemd/system/
                    sed -i 's/\ -H\ fd:\/\///g' /etc/systemd/system/docker.service
                    cp -r functions/f_config_docker.json /etc/docker/daemon.json
                    systemctl start docker.socket
                    systemctl daemon-reload
                    systemctl start docker.service
                    echo "- sleeping for 5s do we can give a chance the Docker daemon to reload;"
                    sleep 5
                else 
                    echo "- but can't configure Docker because it's not installed:"
                    ls -alh /usr/bin/ | grep "docker"
                fi
            else
                echo "- but this isn't a functional architecture for this function." 
            fi
        fi
    fi
}
