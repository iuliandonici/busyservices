#!/bin/bash
function f_config_nginx() {
    # Verify if Nginx has been installed
    if [[ -f /usr/sbin/nginx ]]; then
        echo "- Nginx is installed, now we'll config it."
        if [[ "$EUID" -ne 0 ]]; then 
            sudo mkdir /var/www/busyprod/
            sudo rm -rf /var/www/html/
            sudo rm -rf /etc/nginx/sites-enabled/default
            sudo rm -rf /etc/nginx/sites-available/default
            case $(hostname) in
                busydev)
                    echo "This is $(hostname)."
                    sudo cp -r functions/f_config_nginx_prod.html index.html
                    sudo mv index.html /var/www/busyprod/
                    sudo cp -r functions/f_config_nginx_prod busyprod
                    sudo mv busyprod /etc/nginx/sites-available/
                    sudo ln -s /etc/nginx/sites-available/busyprod /etc/nginx/sites-enabled/busyprod
                ;;
            esac
            sudo service nginx restart
        else
            mkdir /var/www/busyprod/
            rm -rf /var/www/html/
            rm -rf /etc/nginx/sites-enabled/default
            rm -rf /etc/nginx/sites-available/default
            cp -r functions/f_config_nginx.html index.html
            mv index.html /var/www/busyprod/
            cp -r functions/f_config_nginx busyprod
            mv busyprod /etc/nginx/sites-available/
            ln -s /etc/nginx/sites-available/busyprod /etc/nginx/sites-enabled/busyprod
            service nginx restart
        fi
    else
        echo "- Nginx isn't installed:"
        ls -alh /usr/sbin/ | grep "nginx"
    fi
}