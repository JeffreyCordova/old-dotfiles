ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc --utc

vi /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf

echo $hostname >> /etc/hostname
vi /etc/hosts

systemctl enable NetworkManager

vi /etc/pacman.conf
vi /etc/makepkg.conf
reflector --verbose --protocol http --protocol https --latest 200 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

exit
