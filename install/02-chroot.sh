#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc
#---[fix]---------------
vim /etc/locale.gen
#-----------------------
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

echo arch-vm > /etc/hostname

systemctl enable NetworkManager.service

#---[fix]---------------
vim /etc/pacman.conf
vim /etc/makepkg.conf
#-----------------------

reflector \
    --verbose \
    --protocol https \
    --latest 100 \
    --fastest 20 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist
pacman -Syy

bootctl --path=/boot install
cp /usr/share/systemd/bootctl/loader.conf /boot/loader
cp /usr/share/systemd/bootctl/arch.conf /boot/loader/entries
#---[fix]---------------
vim /boot/loader/loader.conf
vim /boot/loader/entries/arch.conf
#-----------------------

exit
