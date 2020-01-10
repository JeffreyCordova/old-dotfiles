parted -a optimal /dev/sda mklabel gpt
parted -a optimal /dev/sda mkpart ESP fat32 0% 1GiB
parted -a optimal /dev/sda set 1 boot on
parted -a optimal /dev/sda mkpart primary ext4 1GiB 100%

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

pacman -Sy --noconfirm reflector
reflector --verbose --protocol http --protocol https --latest 200 --sort rate --save /etc/pacman.d/mirrorlist

curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh

pacstrap /mnt base{,-devel} linux{,-headers,-firmware} grub efibootmgr networkmanager reflector vi git stow

genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt

umount /mnt/boot
umount /mnt

reboot
