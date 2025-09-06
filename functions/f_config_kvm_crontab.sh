#!/bin/bash
function f_config_kvm_crontab () {
    echo " - Adding a new crontab task:"
    echo "@reboot systemctl restart networking.service" >> cronjob_restart_network
    sudo crontab -l > cronjob_restart_network
    sudo crontab cronjob_restart_network
    rm cronjob_restart_network
}