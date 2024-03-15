#!/bin/zsh

set -e

pacstrap /mnt man zsh zsh-completions grml-zsh-config ntfs-3g gdisk util-linux grub efibootmgr amd-ucode base base-devel linux linux-headers linux-lts linux-lts-headers networkmanager wget nano git curl zram-generator reflector smbclient linux-firmware linux-firmware-whence btrfs-progs xfsprogs lvm2
pacstrap /mnt kernel-modules-hook
arch-chroot /mnt zsh -c "pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com;pacman-key --lsign-key 3056513887B78AEB;pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm;pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm"

cat <<-EOF > /mnt/etc/locale.conf
	LANG=en_US.UTF-8
	LC_ADDRESS=nl_NL.UTF-8
	LC_IDENTIFICATION=nl_NL.UTF-8
	LC_MEASUREMENT=nl_NL.UTF-8
	LC_MONETARY=nl_NL.UTF-8
	LC_NAME=nl_NL.UTF-8
	LC_NUMERIC=nl_NL.UTF-8
	LC_PAPER=nl_NL.UTF-8
	LC_TELEPHONE=nl_NL.UTF-8
	LC_TIME=en_GB.UTF-8
EOF

cat /etc/pacman.conf > /mnt/etc/pacman.conf
cat <<-EOF > /mnt/etc/systemd/zram-generator.conf
	[zram0]
	zram-size = ram / 2
	compression-algorithm = zstd
	swap-priority = 100
	fs-type = swap
EOF
cat <<-EOF >> /mnt/etc/pacman.conf
	[chaotic-aur]
	Include = /etc/pacman.d/chaotic-mirrorlist
EOF
