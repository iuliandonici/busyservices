#!/bin/bash
function f_install_cosmic() {
  echo " - Installing Cosmic desktop:"
  echo "- and currently installing xorg-base;"
  doas setup-xorg-base
  echo "- and currently adding the current user to the wheel group;"
  doas adduser $USER wheel
  echo "- and currently installing requirements for the environment;"
  doas apk add elogind dbus polkit-elogind cosmic-session cosmic-term cosmic-edit cosmic-greeter cosmic-greeter-openrc cosmic-icons cosmic-idle cosmic-initial-setup cosmic-launcher cosmic-notifications cosmic-osd cosmic-panel cosmic-randr cosmic-player cosmic-screenshot cosmic-settings cosmic-settings-daemon cosmic-store cosmic-workspaces
  doas rc-update add elogind
  doas rc-update add dbus
  doas rc-update add polkit
  doas setup-devd udev
  doas reboot
}
f_install_cosmic
