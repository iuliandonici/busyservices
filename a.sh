#!/bin/bash
function f_install_cosmic() {
  echo " - Installing Cosmic desktop:"
  doas setup-devd udev
  echo "- and currently installing xorg-base;"
  doas setup-xorg-base
  echo "- and currently adding the current user to the wheel group;"
  doas adduser $USER wheel
  echo "- and currently installing requirements for the environment;"
  doas apk add mate-desktop-environment lxdm adwaita-icon-theme faenza-icon-theme font-dejavu
  gvfs_pkgs=$(apk search gvfs -q | grep -v '\-dev' | grep -v '\-lang' | grep -v '\-doc')
  doas apk add $gvfs_pkgs
  doas rc-update add dbus
  doas rc-update add polkit
  doas rc-update add lxdm
  doas reboot
}
f_install_cosmic
