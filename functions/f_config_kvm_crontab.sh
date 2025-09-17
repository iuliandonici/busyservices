#!/bin/bash
function f_config_kvm_crontab () {
    echo " - Checking if any crontab tasks exist:"
    if [ $(sudo crontab -l | wc -c) -eq 0 ]; then
        echo " crontab is empty so we're creating a new job for it;"
        crontab -l > cronjob_restart_network
        sudo crontab -l > cronjob_restart_network
        echo "@reboot systemctl restart networking.service" >> cronjob_restart_network
        crontab cronjob_restart_network
        sudo crontab cronjob_restart_network
        rm cronjob_restart_network
    else
        echo " crontab is not empty so we're not adding any more jobs;"
    fi
}