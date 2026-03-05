#!/bin/bash
function f_install_cosmic() {
  echo " - Installing Cosmic desktop;"
  doas setup-xorg-base
  echo "- and currently adding the current user to the wheel group;"
  doas adduser $USER wheel
  echo "- and currently installing requirements for the environment;"
  doas apk add elogind dbus polkit-elogind
  doas rc-update add elogind
  doas rc-update add dbus
  doas rc-update add polkit
  doas setup-devd udev
  doas reboot
}
f_install_cosmic
