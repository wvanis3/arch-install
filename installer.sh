printf " - Are you ready to install Arch Linux? (Y/n) - \n"
read choice

if [ "$choice" == "Y" ]; then
	clear
    printf " - Starting the installation... - \n"
    prepare_install()
	pac_strap()
	gen_fstab()
    
else
	clear
    printf "\n - Exiting - \n"
    exit

fi


prepare_install() {
	clear

    # Check for internet connectivity
	printf " - Checking for internet connectivity - \n"
    ping -c 10 google.com
	clear

    # Update the system clock
    printf " - Setting ntp true - \n"
	timedatectl set-ntp true
    timedatectl status
    clear

	# update pacman and install git
	printf " - Updating pacman - \n"
    pacman -Sy --noconfirm
	clear

    # Check disks and partitioning
    lsblk

    printf "\n - Which disk should I install on? - \n"
    read disk_choice
	printf "\n - Installing Arch Linux on ${disk_choice} - \n"
	clear

    # Format efi partition
    printf " - Writing Fat32 filesystem to ${disk_choice}1 - \n"
    mkfs.vfat -F32 ${disk_choice}1

    clear

    # Format swap partition
    printf " - Making swap partition on ${disk_choice}2 - \n"
    mkswap ${disk_choice}2

    clear

    # Format ext4 on root and home
    printf " - Writing Ext4 filesystems to ${disk_choice}3 & ${disk_choice}4 - \n"
    mkfs.ext4 ${disk_choice}3
    mkfs.ext4 ${disk_choice}4

    clear

    # Partition Mounting #

    printf " - Mounting partitions - \n\n${disk_choice}1 as /esp\n${disk_choice}2 as [SWAP]\n${disk_choice}3 as /\n${disk_choice}4 as /home\n\n"

    mount ${disk_choice}3 /mnt
    mkdir /mnt/esp
    mkdir /mnt/home
    mount ${disk_choice}1 /mnt/esp
    mount ${disk_choice}4 /mnt/home
    swapon ${disk_choice}2

	clear && lsblk

    printf " - Partitions are now mounted - \n"
    
}

pac_strap() {
	clear

    # Clone mirror list from github repo
    printf " - Updating mirrorlist - \n"
    git clone https://github.com/wvanis3/archie.git
    cp archie/mirrorlist /etc/pacman.d/mirrorlist

    # Pacstrapping
    printf "\n - Ready to pacstrap - \n"

    pacstrap /mnt base base-devel vim emacs geany firefox-developer-edition chromium ttf-inconsolata termite rxvt-unicode xorg-server xorg-xprop xorg-xinit xorg-xwininfo arandr compton arc-gtk-theme exfat-utils pulseaudio pulseaudio-alsa pavucontrol networkmanager xorg-xdpyinfo zathura zathura-pdf-poppler xorg-xbacklight unrar unzip pcmanfm mpd mpc ncmpcpp mpv vlc audacity libreoffice-fresh kdenlive gimp ranger nm-connection-editor gnome-font-viewer cantarell-fonts neofetch cmatrix asciiquarium lightdm lightdm-gtk-greeter lightdm-gtk-greeter grub efibootmgr lua nodejs npm ffmpeg rofi dmenu zsh lsof deluge tree go intellij-idea-community-edition redshift bat feh w3m vifm sxiv surf python python2 python-pip nitrogen gnome-font-viewer ttf-ibm-plex gnome-terminal ttf-fira-code
}

gen_fstab() {
	clear

	printf " - Generating fstab file - \n"
	genfstab -U /mnt
	genfstab -U /mnt >> /etc/fstab

	printf "\n - Copying git repo to new install - \n"
	cp -r ~/archie /mnt/root

	printf "\n - Now it's time to chroot! - \n"

}
