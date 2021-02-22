#! /bin/bash

passwd=$1

echo $passwd | sudo -S dnf update -y # and reboot if you are not on the latest kernel
echo $passwd | sudo -S dnf install akmod-nvidia -y # rhel/centos users can use kmod-nvidia instead
echo $passwd | sudo -S dnf install xorg-x11-drv-nvidia-cuda -y 

