#!/bin/bash
source functions/f_remove_packages.sh
source functions/f_disable_services.sh
f_remove_packages
f_disable_services
