#!/bin/bash
function f_config_nginx() {
    # Verify if Nginx has been installed
    if [[ -f /usr/sbin/nginx ]]; then
        echo "- Nginx is installed, now we'll config it."
        if [[ "$EUID" -ne 0 ]]; then 
            sudo mkdir /var/www/dev/
            sudo cp -r functions/f_config_nginx.html index.html
            sudo mv index.html /var/www/html/
            sudo service nginx restart
        else
            mkdir /var/www/dev/
            cp -r functions/f_config_nginx.html index.html
            mv index.html /var/www/html/
            service nginx restart
        fi
    else
        echo "- Nginx isn't installed:"
        ls -alh /usr/sbin/ | grep "nginx"
    fi
}