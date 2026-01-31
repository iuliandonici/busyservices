#!/bin/bash
# Not tested on Alpine
var_install_radarr_software_array_alpine=("sqlite3")
var_install_radarr_software_array_debian=("sqlite3")
var_install_radarr_software_array=("sqlite3")
function f_install_radarr() {
    source functions/f_update_software.sh
    f_update_software
    if [[ $(f_get_distro_packager) == "apk" ]]; then
        echo " - here's a list of extra software that will be installed using $(f_get_distro_packager):"
        for i in "${!var_install_radarr_software_array_alpine[@]}"
        do
            echo " $i ${var_install_radarr_software_array_alpine[$i]}"
        done
        for i in "${!var_install_radarr_software_array_alpine[@]}"
        do
            echo "- and currently installing: $i ${var_install_radarr_software_array_alpine[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                doas $(f_get_distro_packager) add ${var_install_radarr_software_array_alpine[$i]}  
            else
                $(f_get_distro_packager) add ${var_install_radarr_software_array_alpine[$i]}  
            fi
        done     
    elif [[ $(f_get_distro_packager) == "apt" || $(f_get_distro_packager) == "apt-get" ]]; then
         for i in "${!var_install_radarr_software_array_debian[@]}"
        do
            echo "- and currently installing: $i ${var_install_radarr_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_radarr_software_array_debian[$i]}
                sudo groupadd media
                sudo usermod -a -G media $USER
                sudo mkdir /var/lib/radarr
                wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
                sudo tar -xzvf Radarr*.linux*.tar.gz
                sudo mv Radarr radarr
                sudo mv radarr /opt/
                sudo chown -R $USER:$USER /opt/radarr
                sudo cat << EOF | sudo tee /etc/systemd/system/radarr.service > /dev/null
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
User=$USER
Group=media
Type=simple

ExecStart=/opt/radarr/Radarr -nobrowser -data=/var/lib/radarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
                sudo systemctl -q daemon-reload
                sudo systemctl enable --now -q $USER
                sudo systemctl restart radarr.service
                sudo rm Radarr*.linux*.tar.gz
            else
                $(f_get_distro_packager) install -y ${var_install_radarr_software_array_debian[$i]}
                groupadd media
                usermod -a -G media $USER
                mkdir /var/lib/radarr
                wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
                tar -xzvf Radarr*.linux*.tar.gz
                mv Radarr radarr
                mv radarr /opt/
                chown -R $USER:$USER /opt/radarr
                cat << EOF | tee /etc/systemd/system/radarr.service > /dev/null
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
User=$USER
Group=media
Type=simple

ExecStart=/opt/radarr/Radarr -nobrowser -data=/var/lib/radarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
                systemctl -q daemon-reload
                systemctl enable --now -q $USER
                systemctl restart radarr.service
                rm Radarr*.linux*.tar.gz
            fi
        done
    elif [[ $(f_get_distro_packager) == "dnf" || $(f_get_distro_packager) == "zypper" ]]; then
        for i in "${!var_install_radarr_software_array[@]}"
        do
            echo "- and currently installing: $i ${var_install_radarr_software_array[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_radarr_software_array[$i]}
            else
                $(f_get_distro_packager) install -y ${var_install_radarr_software_array[$i]}  
            fi
        done        
    else
        for i in "${!var_install_radarr_software_array_debian[@]}"
        do
            echo "- and c1urrently installing: $i ${var_install_radarr_software_array_debian[$i]}"
            if [[ "$EUID" -ne 0 ]]; then 
                sudo $(f_get_distro_packager) install -y ${var_install_radarr_software_array_debian[$i]}  
            else
                $(f_get_distro_packager) install -y ${var_install_radarr_software_array_debian[$i]}  
            fi
            # echo "- Rebooting the network";
            # sudo systemctl restart networking.service 
        done
    fi
    f_update_software
}
