parted -o /dev/sda mklabel gpt
parted -o /dev/sda mkpart ESP fat32 1MiB 513MiB
parted -o /dev/sda set 1 boot on
parted -o /dev/sda mkpart primary ext4 513MiB 100%
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
pacman -Sy --noconfirm reflector
reflector --verbose --protocol http --protocol https --latest 200 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy
pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware grub efibootmgr os-prober ntfs-3g reflector vi networkmanager git stow
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
