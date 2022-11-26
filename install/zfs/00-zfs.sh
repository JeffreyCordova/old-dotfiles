#!/bin/bash

#declare disk (array)
DISK='/dev/disk/by-id/scsi-DISK1 /dev/disk/by-id/nvme-DISK2'

#set swap size (in GiB)
#INST_PARTSIZE_SWAP=8

#set root pool size, use all remaining disk space if not set
INST_PARTSIZE_RPOOL=

#add archzfs repo, install zfs-{linux,utils}, and load modules
curl -s https://raw.githubusercontent.com/eoli3n/archiso-zfs/master/init \
    | bash -s -- -v

--------

#partition the disks
for i in ${DISK}; do
    sgdisk --zap-all $i

    sgdisk -n1:1M:+1G -t1:EF00 $i
    sgdisk -n2:0:+4G -t2:BE00 $i

    test -z $INST_PARTSIZE_SWAP || \
        sgdisk -n4:0:+${INST_PARTSIZE_SWAP}G -t4:8200 $i

    if test -z $INST_PARTSIZE_RPOOL; then
        sgdisk -n3:0:0 -t3:BF00 $i
    else
        sgdisk -n3:0:+${INST_PARTSIZE_RPOOL}G -t3:BF00 $i
    fi

    sgdisk -a1 -n5:24K:+1000K -t5:EF02 $i
done

#create boot pool
#if not using a multi-disk setup, remove "mirror"
zpool create \
    -o compatibility=grub2 \
    -o ashift=12 \
    -o autotrim=on \
    -O acltype=posixacl \
    -O canmount=off \
    -O compression=lz4 \
    -O devices=off \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=/boot \
    -R /mnt \
    bpool \
    mirror \
    $(for i in ${DISK}; do
         printf "$i-part2 ";
      done)

#create root pool
zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -R /mnt \
    -O acltype=posixacl \
    -O canmount=off \
    -O compression=zstd \
    -O dnodesize=auto \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=/ \
    rpool \
    mirror \
        $(for i in ${DISK}; do
             printf "$i-part3 ";
	 done)

#create root system container, unecrypted
zfs create \
    -o canmount=off \
    -o mountpoint=none \
    rpool/archlinux

#create root system container, encrypted
zfs create \
    -o canmount=off \
    -o mountpoint=none \
    -o encryption=on \
    -o keylocation=prompt \
    -o keyformat=passphrase \
    rpool/archlinux

#create system datasets
zfs create -o canmount=on -o mountpoint=/     rpool/archlinux/root
zfs create -o canmount=on -o mountpoint=/home rpool/archlinux/home
zfs create -o canmount=off -o mountpoint=/var rpool/archlinux/var
zfs create -o canmount=on rpool/archlinux/var/lib
zfs create -o canmount=on rpool/archlinux/var/log

#create boot dataset
zfs create -o canmount=off -o mountpoint=none bpool/archlinux
zfs create -o canmount=on -o mountpoint=/boot bpool/archlinux/root

#format and mount ESP
for i in ${DISK}; do
    mkfs.vfat -n EFI ${i}-part1
    mkdir -p /mnt/boot/efis/${i##*/}-part1
    mount -t vfat ${i}-part1 /mnt/boot/efis/${i##*/}-part1
done

mkdir -p /mnt/boot/efi
mount -t vfat $(echo $DISK | cut -f1 -d\ )-part1 /mnt/boot/efi

#install packages
pacstrap /mnt base{,-devel} vi vim mandoc grub efibootmgr mkinitcpio pigz pbzip2

CompatibleVer=$(pacman -Si zfs-linux | grep 'Depends On' | sed "s|.*linux=||" | awk '{ print $1 }')
pacstrap -U /mnt https://archive.archlinux.org/packages/l/linux/linux-${CompatibleVer}-x86_64.pkg.tar.zst

pacstrap /mnt zfs-linux zfs-utils

pacstrap /mnt linux-firmware intel-ucode amd-ucode

#generate fstab
mkdir -p /mnt/etc/
for i in ${DISK}; do
    echo UUID=$(blkid -s UUID -o value ${i}-part1) /boot/efis/${i##*/}-part1 vfat \
        umask=0022,fmask=0022,dmask=0022 0 1 >> /mnt/etc/fstab
done

echo $(echo $DISK | cut -f1 -d\ )-part1 /boot/efi vfat \
    noauto,umask=0022,fmask=0022,dmask=0022 0 1 >> /mnt/etc/fstab

#configure mkinitcpio
mv /mnt/etc/mkinitcpio.conf /mnt/etc/mkinitcpio.conf.original
tee /mnt/etc/mkinitcpio.conf <<EOF
HOOKS=(base udev autodetect modconf block keyboard zfs filesystems)
EOF

#enable internet time synchronization
hwclock --systohc
systemctl enable systemd-timesyncd --root=/mnt

#set locale, keymap, timezone, hostname, and root password
rm -f /mnt/etc/localtime
systemd-firstboot --root=/mnt --prompt --force

#generate host id
zgenhostid -f -o /mnt/etc/hostid

#enable ZFS services
systemctl enable zfs-import-scan.service zfs-mount zfs-import.target zfs-zed zfs.target --root=/mnt

#add archzfs repos
curl -L https://archzfs.com/archzfs.gpg | pacman-key -a - --gpgdir /mnt/etc/pacman.d/gnupg
pacman-key --lsign-key --gpgdir /mnt/etc/pacman.d/gnupg $(curl -L https://git.io/JsfVS)
curl -L https://git.io/Jsfw2 > /mnt/etc/pacmand.d/mirrorlist-archzfs

tee -a /mnt/etc/pacman.conf <<- 'EOF'

#[archzfs-testing]
#Include = /etc/pacman.d/mirrorlist-archzfs

[archzfs]
Include = /etc/pacman.d/mirrorlist-archzfs
EOF

#chroot
history -w /mnt/home/sys-install-pre-chroot.txt
arch-chroot /mnt /usr/bin/env DISK="$DISK" bash

#generate locales
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

#create empty cache and generate initrd
rm -f /etc/zfs/zpool.cache
touch /etc/zfs/zpool.cache
chmod a-w /etc/zfs/zpool.cache
chattr +i /etc/zfs/zpool.cache

mkinitpio -P

#apply GRUB workaround
echo 'export ZPOOL_VDEV_NAME_PATH=YES' >> /etc/profile.d/zpool_vdev_name_path.sh
soruce /etc/profile.d/zpool_vdev_name_path.sh

#GRUB fails to detect rpool name, hard code as "rpool"
sed -i "s|rpool=.*|rpool=rpool|" /etc/grub.d/10_linux

echo GRUB_CMDLINE_LINUX=\"zfs_import_dir=/dev/disk/by-id/\" >> /etc/default/grub
#IMPORTANT: This workaround needs to be applied for every GRUB update, as the
#    update will overwrite the changes.


#install GRUB
export ZPOOL_VDEV_NAME_PATH=YES
mkdir -p /boot/efi/arch/grub-bootdir/i386-pc/
mkdir -p /boot/efi/arch/gurb-bootdir/x86_64-efi/
for i in ${DISK}; do
     grub-install --target=i386-pc --boot-directory \
         /boot/efi/arch/grub-bootdir/i386-pc/ $i
done
grub-install --target x86_64-efi --boot-directory \
    /boot/efi/arch/grub-bootdir/x86_64-efi/ --efi-directory \
    /boot/efi --bootloader-id arch --removable

#create GRUB menu
grub-mkconfig -o /boot/efi/arch/grub-bootdir/x86_64-efi/grub/grub.cfg
grub-mkconfig -o /boot/efi/arch/grub-bootdir/i386-pc/grub/grub.cgf

#for both legacy and EFI booting: mirror ESP content
ESP_MIRROR=$(mktemp -d)
cp -r /boot/efi/EFI $ESP_MIRROR
for i in /boot/efis/*; do
    cp -r $ESP_MIRROR/EFI $i
done
rm -rf $ESP_MIRROR

#exit chroot
exit

#export pools
umount -Rl /mnt
zpool export -a

#reboot
reboot

