#!/bin/bash
function f_get_distro_packager() {
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        ID=$ID
        OS=$NAME
        VER=$VERSION_ID
        if [[ -f /usr/bin/apt ]]; then
            echo "apt"
        elif [[ -f /usr/bin/apt-get ]]; then
            echo "apt-get"
        elif [[ $ID == "alpine" ]]; then
            echo "apk"
        elif [[ $ID == "centos" ]]; then
                echo "yum"   
        elif [[ $ID == "almalinux" || $ID == "fedora" ]]; then
                echo "dnf"   
        elif [[ $ID == "opensuse-leap" ]]; then
                echo "zypper" 
        fi       
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
        echo $ID
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
        echo $OS
    elif [ -f /etc/debian_version ]; then
        # Older Debian/Ubuntu/etc.
        ID="debian"
        OS="Debian"
        VER=$(cat /etc/debian_version)
        echo $ID
    elif [ -f /etc/SuSe-release ]; then
        # Older SuSE/etc.
        echo "This is a a SuSe release."
    elif [ -f /etc/redhat-release ]; then
        # Older Red Hat, CentOS, etc.
        echo "This a RedHat release."
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        OS=$(uname -s)
        VER=$(uname -r)
    fi
}