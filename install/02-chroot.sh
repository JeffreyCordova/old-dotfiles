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
    --latest 50 \
    --fastest 10 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist

curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh

bootctl --path=/boot install
cp boot/loader.conf /boot/loader
cp boot/arch.conf /boot/loader/entries

exit
