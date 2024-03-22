#!/bin/zsh

set -e

# The mirrorlist for those living in the Netherlands. Change if needed.
cat <<-'EOF' > /etc/pacman.d/mirrorlist
	Server = https://mirror.erickochen.nl/archlinux/$repo/os/$arch
	Server = https://mirror.nekos.host/$repo/os/$arch
	Server = https://arch.kurdy.org/$repo/os/$arch
	Server = https://mirror.hugo-betrugo.de/archlinux/$repo/os/$arch
	Server = https://archlinux.mirror.wearetriple.com/$repo/os/$arch
	Server = https://mirror.cj2.nl/archlinux/$repo/os/$arch
	Server = https://mirror.koddos.net/archlinux/$repo/os/$arch
	Server = https://nl.mirror.flokinet.net/archlinux/$repo/os/$arch
	Server = https://arch.mirrors.lavatech.top/$repo/os/$arch
	Server = https://mirrors.xtom.de/archlinux/$repo/os/$arch
	Server = https://mirrors.xtom.nl/archlinux/$repo/os/$arch
	Server = https://mirror.netcologne.de/archlinux/$repo/os/$arch
	Server = https://mirror.serverion.com/archlinux/$repo/os/$arch
	Server = https://arch.phinau.de/$repo/os/$arch
	Server = https://mirror.ubrco.de/archlinux/$repo/os/$arch
	Server = https://mirror.bouwhuis.network/archlinux/$repo/os/$arch
	Server = https://mirror.fra10.de.leaseweb.net/archlinux/$repo/os/$arch
	Server = https://mirror.pseudoform.org/$repo/os/$arch
	Server = https://mirror.bethselamin.de/$repo/os/$arch
	Server = https://ftp.fau.de/archlinux/$repo/os/$arch
EOF

# Installing the base system and the Yay AUR Wrapper. The Chaotic-Aur repo is included.
pacman -Syy
pacstrap /mnt man zsh zsh-completions grml-zsh-config ntfs-3g gdisk util-linux grub efibootmgr amd-ucode base base-devel linux-zen linux-zen-headers linux-lts linux-lts-headers networkmanager wget nano git curl zram-generator reflector smbclient linux-firmware linux-firmware-whence btrfs-progs xfsprogs lvm2
pacstrap /mnt kernel-modules-hook
arch-chroot /mnt zsh -c "pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com;pacman-key --lsign-key 3056513887B78AEB && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm"
cat /etc/pacman.conf > /mnt/etc/pacman.conf
cat <<-EOF >> /mnt/etc/pacman.conf
	[chaotic-aur]
	Include = /etc/pacman.d/chaotic-mirrorlist
EOF
arch-chroot /mnt zsh -c "pacman -Sy --needed --noconfirm upd72020x-fw yay"

# Changes the locales to those used in the Netherlands, while keeping the English Language. You still need to edit the "locale.gen" file.
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

# Configures the zram generator
cat <<-EOF > /mnt/etc/systemd/zram-generator.conf
	[zram0]
	zram-size = ram / 2
	compression-algorithm = zstd
	swap-priority = 100
	fs-type = swap
EOF
