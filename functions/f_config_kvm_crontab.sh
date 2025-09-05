#!/bin/bash
function f_config_kvm_crontab () {
    echo " - Adding a new crontab task:"
    crontab -l > cronjob_restart_network
    echo "systemctl restart networking.service" >> cronjob_restart_network
    crontab cronjob_restart_network
    rm cronjob_restart_network
}