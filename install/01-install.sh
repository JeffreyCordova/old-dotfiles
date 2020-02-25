#!/bin/bash

parted -o /dev/sda mklabel gpt
parted -o /dev/sda mkpart ESP fat32 0% 1GiB
parted -o /dev/sda set 1 boot on
parted -o /dev/sda mkpart primary ext4 1GiB 100%

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

pacman -Sy --noconfirm reflector
reflector \
    --verbose \
    --protocol https \
    --latest 100 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist
pacman -Syy

pacstrap /mnt \
    base{,-devel} linux{,-headers,-firmware} \
    intel-ucode efibootmgr \
    pigz pbzip2 \
    networkmanager \
    reflector \
    vi vim \
    git stow \
    rustup

genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt 02-chroot.sh
