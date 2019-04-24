printf "Hello! Welcome to Will Vanis' Arch Linux Installer!\nThis simple script will install Arch Linux for you!"

sleep 5s

printf "Checking internet connection...\n"
ping -c 5 archlinux.org

printf "Turning on NTP service...\n"

timedatectl set-ntp true
timedatectl status
sleep 2s

clear

printf "Please partition your disks.\n"

gdisk /dev/sda

mkfs.ext4 /dev/sda2
mkfs.vfat -F32 /dev/sda1
mkswap /dev/sda3
swapon /dev/sda3

sleep 2s
clear

printf "Mounting the partitions to for the new install..."

mount /dev/sda2 /mnt
mkdir /mnt/esp
mount /dev/sda1 /mnt/esp

sleep 2s
clear

lsblk

read -p "Is this layout correct? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	
	cp ~/archie/mirrorlist /etc/pacman.d/mirrorlist
	pacman -Syy
	sleep 2s && clear
	
	pactrap /mnt base base-devel vim git
	sleep 2s && clear
	
	genfstab -U /mnt >> /mnt/etc/fstab
	cat /mnt/etc/fstab
	sleep 2s && clear
	
else
	exit 0
fi

printf "Time to chroot and keep going!"













