#!/bin/bash
wget -q -X "*.10" http://cdimage.ubuntu.com/releases/ -O - | awk '! ($0 % 2)' |sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | grep '^[[:space:][:space:]][1-9]' | grep '.04.*' | sed 's/\///g' > ubuntuversions 
awk '! ($0 % 2)' ubuntuversions | sort -nr | head -1 > latestubuntuversion
awk '{print $1 $2}' latestubuntuversion > lastubuntuversion
var_latest_ubuntu_version=$(cat lastubuntuversion)
wget https://releases.ubuntu.com/$var_latest_ubuntu_version/ubuntu-$var_latest_ubuntu_version-live-server-amd64.iso

# rm -rf ubuntuversions latestubuntuversion
