#!/bin/bash

pacstrap /mnt man zsh zsh-completions grml-zsh-config grub efibootmgr amd-ucode base base-devel linux linux-headers linux-lts linux-lts-headers networkmanager wget nano git curl zram-generator reflector smbclient linux-firmware linux-firmware-whence btrfs-progs xfsprogs lvm2
pacstrap /mnt kernel-modules-hook

cat <<-EOF >> /mnt/etc/locale.conf
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
