#!/bin/bash
function f_install_cosmic() {
  echo " - Installing Cosmic desktop;"
  echo "- and currently adding the current user to the wheel group;"
  doas adduser $USER wheel
  doas apk add elogind dbus polkit-elogind cosmic-session cosmic-term cosmic-edit
  doas rc-update add elogind
  doas rc-update add dbus
  doas rc-update add polkit
  doas setup-devd udev
  doas reboot
}
f_install_cosmic
