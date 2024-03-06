#!/bin/bash
set -e

yay -S bc rsync mlocate bash-completion pkgstats zip unzip unrar p7zip lzop cpio avahi nss-mdns alsa-utils alsa-plugins dosfstools exfat-utils f2fs-tools fuse fuse-exfat mtpfs xorg-server xorg-apps xorg-xinit xorg-xkill xorg-xinput xf86-input-libinput mesa weston xorg-server-xwayland --needed

yay -S --asdeps --needed cairo fontconfig freetype2

# change vbox drivers to your video card
yay -S dmidecode virtualbox-guest-utils mesa-libgl xf86-video-vmware cups cups-pdf gutenprint ghostscript gsfonts foomatic-db foomatic-db-engine foomatic-db-nonfree foomatic-db-ppds foomatic-db-nonfree-ppds foomatic-db-gutenprint-ppds sddm sddm-kcm cinnamon nemo-fileroller nemo-preview gnome-screenshot gedit gnome-terminal gnome-control-center gnome-system-monitor gnome-power-manager mintlocale pipewire pipewire-alsa pipewire-pulse lib32-pipewire lib32-alsa-lib lib32-alsa-plugins archlinux-artwork archlinux-wallpaper keepassxc xviewer flatpak pamac-nosnap gnome-calculator-gtk3 yt-dlp candy-icons-git sweet-kde-git sweet-gtk-theme sweet-gtk-theme-dark masterpdfeditor-free dnsmasq networkmanager-openconnect networkmanager-openvpn networkmanager-pptp networkmanager-vpnc network-manager-applet nm-connection-editor gnome-keyring bluez bluez-utils gparted ufw gufw icoutils wine wine_gecko wine-mono winetricks gimp simple-scan google-chrome firefox transmission-gtk thunderbird easytag mpv vlc handbrake-gtk gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav libdvdnav libdvdcss cdrdao cdrtools ffmpeg ffmpegthumbnailer ffmpegthumbs ttf-ms-fonts noto-fonts-cjk --needed

yay -Rsc --noconfirm $(yay -Qdqt)

gconftool-2 --type string --set /system/gstreamer/0.10/audio/profiles/mp3/pipeline \audio/x-raw-int,rate=44100,channels=2 ! lame name=enc preset=1001 ! id3v2mux\"
sudo sddm --example-config | sudo tee /etc/sddm.conf
sudo sed -i 's/Current=/Current=breeze/' /etc/sddm.conf
sudo sed -i 's/CursorTheme=/CursorTheme=breeze_cursors/' /etc/sddm.conf
sudo sed -i 's/Numlock=none/Numlock=on/' /etc/sddm.conf
sudo systemctl gufw
sudo systemctl enable sddm
sudo systemctl enable bluetooth.service
sudo systemctl set-default graphical.target
# if not needed, remove vbox modules
sudo modprobe vboxguest vboxsf vboxvideo virtualbox-guest uinput
sudo usermod "$USER" -aG vboxsf
sudo timedatectl set-ntp true
sudo systemctl enable avahi-daemon.service

sudo flatpak install --system --assumeyes spotify onlyoffice kdenlive
