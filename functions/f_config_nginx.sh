#!/bin/bash
function f_config_nginx() {
    # Verify if Nginx has been installed
    if [[ -f /usr/sbin/nginx ]]; then
        echo "- Nginx is installed, now we'll config it."
        if [[ "$EUID" -ne 0 ]]; then 
            sudo rm -rf /var/www/html/
            sudo rm -rf /etc/nginx/sites-enabled/default
            sudo rm -rf /etc/nginx/sites-available/default
            case $(hostname) in
                busydev)
                    echo "This is $(hostname)."
                    sudo rm -rf /etc/nginx/sites-enabled/busydev
                    sudo rm -rf /etc/nginx/sites-available/busydev
                    sudo rm -rf /var/www/busydev/
                    sudo mkdir /var/www/busydev/
                    sudo cp -r functions/f_config_nginx_dev.html index.html
                    sudo mv index.html /var/www/busydev/
                    sudo cp -r functions/f_config_nginx_dev busydev
                    sudo mv busydev /etc/nginx/sites-available/
                    sudo ln -s /etc/nginx/sites-available/busydev /etc/nginx/sites-enabled/busydev
                ;;
                busycenter)
                    echo "This is $(hostname)."
                    sudo rm -rf /etc/nginx/sites-enabled/busyprod
                    sudo rm -rf /etc/nginx/sites-available/busyprod
                    sudo rm -rf /var/www/busyprod/
                    sudo mkdir /var/www/busyprod/
                    sudo cp -r functions/f_config_nginx_prod.html index.html
                    sudo mv index.html /var/www/busyprod/
                    sudo cp -r functions/f_config_nginx_prod busyprod
                    sudo mv busyprod /etc/nginx/sites-available/
                    sudo ln -s /etc/nginx/sites-available/busyprod /etc/nginx/sites-enabled/busyprod
                ;;
            esac
            sudo service nginx restart
        else
            rm -rf /var/www/html/
            rm -rf /etc/nginx/sites-enabled/default
            rm -rf /etc/nginx/sites-available/default
            case $(hostname) in
                busydev)
                    echo "This is $(hostname)."
                    rm -rf /etc/nginx/sites-enabled/busydev
                    rm -rf /etc/nginx/sites-available/busydev
                    rm -rf /var/www/busydev/
                    mkdir /var/www/busydev/
                    cp -r functions/f_config_nginx_dev.html index.html
                    mv index.html /var/www/busydev/
                    cp -r functions/f_config_nginx_dev busydev
                    mv busydev /etc/nginx/sites-available/
                    ln -s /etc/nginx/sites-available/busydev /etc/nginx/sites-enabled/busydev
                ;;
                busycenter)
                    echo "This is $(hostname)."
                    rm -rf /etc/nginx/sites-enabled/busyprod
                    rm -rf /etc/nginx/sites-available/busyprod
                    rm -rf /var/www/busyprod/
                    mkdir /var/www/busyprod/
                    cp -r functions/f_config_nginx_prod.html index.html
                    mv index.html /var/www/busyprod/
                    cp -r functions/f_config_nginx_prod busyprod
                    mv busyprod /etc/nginx/sites-available/
                    ln -s /etc/nginx/sites-available/busyprod /etc/nginx/sites-enabled/busyprod
                ;;
            esac
            service nginx restart
        fi
    else
        echo "- Nginx isn't installed:"
        ls -alh /usr/sbin/ | grep "nginx"
    fi
}