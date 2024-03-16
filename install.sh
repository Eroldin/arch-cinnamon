#!/bin/zsh
set -e

yay -S bc rsync mlocate bash-completion pkgstats zip unzip unrar p7zip lzop cpio avahi nss-mdns alsa-utils alsa-plugins dosfstools exfat-utils f2fs-tools fuse fuse-exfat mtpfs xorg-server xorg-apps xorg-xinit xorg-xkill xorg-xinput xf86-input-libinput mesa weston xorg-server-xwayland --needed --noconfirm

yay -S --asdeps --needed --noconfirm cairo fontconfig freetype2

yay -S dmidecode mesa-libgl cups cups-pdf system-config-printer gutenprint watchdog breeze gnome-themes-extra xdg-user-dirs-gtk cinnamon-sounds ghostscript gsfonts foomatic-db foomatic-db-engine foomatic-db-nonfree foomatic-db-ppds foomatic-db-nonfree-ppds foomatic-db-gutenprint-ppds sddm sddm-kcm cinnamon nemo-fileroller nemo-preview gnome-screenshot gedit gnome-terminal-transparency gnome-control-center gnome-system-monitor gnome-power-manager mintlocale pipewire pipewire-alsa pipewire-pulse lib32-pipewire lib32-alsa-lib lib32-alsa-plugins archlinux-artwork archlinux-wallpaper keepassxc xviewer flatpak pamac-nosnap gnome-calculator yt-dlp candy-icons-git sweet-kde-git sweet-gtk-theme sweet-gtk-theme-dark masterpdfeditor-free dnsmasq networkmanager-openconnect networkmanager-openvpn networkmanager-pptp networkmanager-vpnc network-manager-applet nm-connection-editor gnome-keyring bluez bluez-utils gparted ufw gufw icoutils wine wine_gecko wine-mono winetricks gimp simple-scan google-chrome firefox transmission-gtk thunderbird easytag mpv vlc handbrake-gtk gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav libdvdnav libdvdcss cdrdao cdrtools ffmpeg ffmpegthumbnailer ffmpegthumbs ttf-ms-fonts noto-fonts-cjk --needed --noconfirm
 sudo ln -sf /usr/lib/libalpm.so.14.0.0 /usr/lib/libalpm.so.13
# If using Gnome Boxes
# yay -S --needed --noconfirm spice spice-gtk spice-protocol spice-vdagent
yay -Rsc --noconfirm $(yay -Qdqt)

sudo sddm --example-config | sudo tee /etc/sddm.conf
sudo sed -i 's/Current=/Current=breeze/' /etc/sddm.conf
sudo sed -i 's/CursorTheme=/CursorTheme=breeze_cursors/' /etc/sddm.conf
sudo sed -i 's/Numlock=none/Numlock=on/' /etc/sddm.conf
sudo systemctl enable --now watchdog
sudo systemctl enable ufw
sudo ufw enable
sudo systemctl enable sddm
sudo systemctl enable bluetooth.service
sudo systemctl set-default graphical.target
sudo timedatectl set-ntp true
sudo systemctl enable avahi-daemon.service

sudo flatpak install --system --assumeyes spotify onlyoffice kdenlive
