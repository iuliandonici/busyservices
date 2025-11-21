#!/bin/bash
function f_reload_nginx {
  source functions/f_config_nginx.sh
  f_config_nginx
}
f_reload_nginx
