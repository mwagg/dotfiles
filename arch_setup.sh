#!/usr/bin/env bash

set -e

function log {
	echo -e "\e[32m$1\e[0m"
}

if [[ -z "$BOOT_PARTITION" ]]; then
	echo "You must set the BOOT_PARTITION variable"
	exit 1
fi
if [[ -z "$ROOT_PARTITION" ]]; then
	echo "You must set the ROOT_PARTITION variable"
	exit 1
fi
if [[ -z "$HOSTNAME" ]]; then
	echo "You must set the HOSTNAME variable"
	exit 1
fi

loadkeys uk
timedatectl set-ntp true

log "Creating encrypted root partition"
cryptsetup -y -v luksFormat --type luks2 $ROOT_PARTITION
cryptsetup config --label=root $ROOT_PARTITION
cryptsetup open $ROOT_PARTITION cryptroot
mkfs.ext4 /dev/mapper/cryptroot

log "Mounting partitions"
mount /dev/mapper/cryptroot /mnt
mkdir /mnt/boot
mount $BOOT_PARTITION /mnt/boot

function finish {
  log "Unmounting partitions"
  umount -R /mnt
  cryptsetup close cryptroot
}
trap finish EXIT

log "Configuring mirrors"
pacman -Syy --noconfirm
pacman -S --noconfirm reflector
reflector -c "United Kingdom" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

log "Pacstrap installation"
pacstrap /mnt/ base base-devel sudo intel-ucode efibootmgr wpa_supplicant networkmanager git
genfstab -U /mnt >> /mnt/etc/fstab

log "Configuring hostname"
echo $HOSTNAME > /mnt/etc/hostname
cat << EOF > /mnt/etc/hosts
                   127.0.0.1	localhost
                   ::1		localhost
                   127.0.1.1	$HOSTNAME.localdomain $HOSTNAME
EOF

log "Configuring initcpio"
sed -i /mnt/etc/mkinitcpio.conf -e 's/MODULES=()/MODULES=(ext4)/'
sed -i /mnt/etc/mkinitcpio.conf -e 's/HOOKS=(base udev autodetect modconf/HOOKS=(base udev autodetect keyboard keymap encrypt modconf/'

log "Configureing systemd-boot"
mkdir -p /mnt/boot/loader/entries
cat <<EOF > /mnt/boot/loader/loader.conf
default arch
timeout 0
console-mode max
editor no
EOF

cat <<EOF > /mnt/boot/loader/entries/arch.conf
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options cryptdevice=LABEL=root:cryptroot:allow-discards root=/dev/mapper/cryptroot rw quiet
EOF

cat << EOF > /mnt/arch_install.sh
	ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
	echo "KEYMAP=uk" > /etc/vconsole.conf
	hwclock --systohc
	sed -i /etc/locale.gen -e 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/'
	locale-gen
	echo "LANG=en_GB.UTF-8" > /etc/locale.conf
	mkinitcpio -p linux
	echo "Setting password for root"
	passwd
	echo "%wheel ALL=(ALL) ALL" | sudo EDITOR='tee -a' visudo
        bootctl --path=/boot install

	echo "Setting passwd for user"
	useradd -m -g users -G wheel -s /bin/bash mike
	passwd mike

	systemctl enable NetworkManager.service
EOF
chmod +x /mnt/arch_install.sh

arch-chroot /mnt /arch_install.sh
