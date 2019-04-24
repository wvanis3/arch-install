printf "Cloning github repo...\n"
cd ~
git clone https://github.com/wvanis3/arch-install

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

cd arch-install

cp hosts /etc/
cp hostname /etc/
cp locale.gen /etc/
cp locale.conf /etc/

locale-gen

bash programs.sh

sleep 6s && clear

printf "Enabling services..."

systemctl enable NetworkManager
systemctl enable lightdm.service

cp lightdm.conf /etc/lightdm/

passwd

useradd -mg wheel will
passwd will

sleep 2s && clear
mkdir -p /home/will/Pictures/Wallpapers
mkdir -p /home/will/Documents
mkdir -p /home/will/Downloads
mkdir -p /home/will/Videos
mkdir -p /home/will/Music

sleep 2s && clear

kak /etc/sudoers

cd /

mount /dev/nvme0n1p2 /mnt

grub-install --target=x86_64-efi --efi-directory=/esp --bootloader-id=ArchLinux
grub-mkconfig -o /boot/grub/grub.cfg

umount -R /mnt