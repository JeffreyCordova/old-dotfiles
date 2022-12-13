#!/bin/bash

# store pool passphrase in file
echo '<passphrase>' > /etc/zfs/zroot.key
chmod 000 /etc/zfs/zroot.key

# list disks
ls -la /dev/disk/by-id

# save disk path in a variable
DISK='/dev/disk/by-id/nvme-KXG60ZNV512G_KIOXIA_12HC60A3ETR2'
DISK='/dev/disk/by-id/scsi-36000c29ee956881ae3a45fcd9265c919'

# add ArchZFS repository
curl -L https://archzfs.com/archzfs.gpg | pacman-key -a -
pacman-key --lsign-key $(curl -L https://git.io/JsfVS)
curl -L https://git.io/Jsfw2 > /etc/pacman.d/mirrorlist-archzfs

tee -a /etc/pacman.conf <<- 'EOF'

#[archzfs-testing]
#Include = /etc/pacman.d/mirrorlist-archzfs

[archzfs]
Include = /etc/pacman.d/mirrorlist-archzfs
EOF

# partition the disk
sgdisk --zap-all $DISK
sgdisk -n1:1M:+1G -t1:ef00 $DISK
sgdisk -n2:0:0    -t2:bf00 $DISK

# create zroot pool
zpool create -f -o ashift=12                             \
                -o autotrim=on                           \
                -O compression=lz4                       \
                -O acltype=posixacl                      \
                -O xattr=sa                              \
                -O relatime=on                           \
                -O encryption=aes-256-gcm                \
                -O keylocation=file:///etc/zfs/zroot.key \
                -O keyformat=passphrase                  \
                -m none zroot ${DISK}-part2 

# create datasets
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=/ -o canmount=noauto zroot/ROOT/arch
zfs create -o mountpoint=/home zroot/home

# test pool by exporting/importing
zpool export zroot
zpool import -N -R /mnt zroot
zfs load-key -L prompt zroot
zfs mount zroot/ROOT/arch
zfs mount zroot/home

# check if pool is mounted correctly
mount | grep mnt

# create and mount EFI partition
mkfs.vfat -F 32 -n EFI $DISK-part1
mkdir /mnt/efi
mount $DISK-part1 /mnt/efi

# install arch linux
pacstrap /mnt base{,-devel}                      \
              linux{-zen,-zen-headers,-firmware} \
              intel-ucode efibootmgr mkinitcpio  \
              zfs{-dkms,-utils}                  \
              pigz pbzip2                        \
              networkmanager polkit              \
              reflector                          \
              vi vim mandoc                      \
              git stow                           \
              openssh wget                       \
              rustup

# generate hostid
zgenhostid -f -o /mnt/etc/hostid

# copy over key and resolv.conf
cp /etc/resolv.conf /mnt/etc
mkdir -p /mnt/etc/zfs
cp /etc/zfs/zroot.key /mnt/etc/zfs

# add ArchZFS repository
curl -L https://archzfs.com/archzfs.gpg | pacman-key -a - --gpgdir /mnt/etc/pacman.d/gnupg
pacman-key --lsign-key --gpgdir /mnt/etc/pacman.d/gnupg $(curl -L https://git.io/JsfVS)
curl -L https://git.io/Jsfw2 > /mnt/etc/pacman.d/mirrorlist-archzfs

tee -a /mnt/etc/pacman.conf <<- 'EOF'

#[archzfs-testing]
#Include = /etc/pacman.d/mirrorlist-archzfs

[archzfs]
Include = /etc/pacman.d/mirrorlist-archzfs
EOF

# generate fstab
genfstab /mnt > /mnt/etc/fstab
vim /mnt/etc/fstab

# chroot into new system
arch-chroot /mnt /usr/bin/env DISK="$DISK" bash

# set the time zone
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# generate /etc/adjtime
hwclock --systohc

# generate locale
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen

# set LANG variable
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

# sett hostname
echo 'arch-vm' > /etc/hostname

# edit /etc/hosts
vim /etc/hosts

# edit /etc/mkinitcpio.conf
mv /etc/mkinitcpio.conf /etc/mkinitcpio.conf.original
tee /etc/mkinitcpio.conf <<EOF
FILES=(/etc/zfs/zroot.key)

HOOKS=(base udev autodetect modconf block keyboard zfs filesystems)
EOF

# generate new initramfs
mkinitcpio -P

# set root password
passwd

#set zfs cachefile
zpool set cachefile=/etc/zfs/zpool.cache zroot

# set zfs bootfs
zpool set bootfs=zroot/ROOT/arch zroot

# enable all needed daemons
systemctl enable zfs-import-cache  \
                 zfs-import.target \
                 zfs-mount         \
                 zfs-zed           \
                 zfs.target

# enable NetworkManager
systemctl enable NetworkManager

# create efi subfolder
mkdir -p /efi/EFI/zbm

# get latest ZFSBootMenu release
wget https://get.zfsbootmenu.org/latest.EFI -O /efi/EFI/zbm/zfsbootmenu.EFI

# add boot entry
efibootmgr --disk $DISK                         \
           --part 1                             \
           --create                             \
           --label "ZFSBootMenu"                \
           --loader '\EFI\zbm\zfsbootmenu.EFI'  \
           --unicode "spl_hostid=$(hostid)      \
                      zbm.timeout=10            \
                      zbm.prefer=zroot          \
                      zbm.import_policy=hostid" \
           --verbose

zfs set org.zfsbootmenu:commandline="noresume init_on_alloc=0 rw spl.spl_hostid" zroot/ROOT

# exit chroot
exit

# unmount EFI partition
umount /mnt/efi

# export zpool and reboot
zpool export zroot

reboot

