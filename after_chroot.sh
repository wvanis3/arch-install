printf " - Updating pacman - \n"
pacman -Syu --noconfirm
clear

printf " - Configuring your locale - \n"
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
nano /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
clear

printf " - Configuring your hostname/hosts - \n"
touch /etc/hostname
printf "\n - Please enter your new hostname for this machine - \n"
read host_name
echo "${host_name}" >> /etc/hostname
nano /etc/hosts

clear
printf "\n - Setting root password - \n"
passwd

printf "\n - Install microcode updates for processor (AMD or Intel?) - \n"
read cpu
if [ "$cpu" == "AMD" ] then
	pacman -S amd-ucode
else
	pacman -S intel-ucode
fi

clear

printf "\n - Installing Grub - \n"
grub-install --target=x86_64-efi --efi-directory=esp/ --bootloader-id=Linux
printf "\n - Making grub config - \n"
grub-mkconfig -o /boot/grub/grub.config
clear

printf " - Making 'initcpio' - \n"
mkinitcpio -p linux
clear

printf " - Enabling NetworkManager - \n"
systemctl enable NetworkManager
clear

printf " - Now it's time to create your user account - \n"
printf "\n - Username - \n"
read u_name

printf "\n - Creating user & adding them to the 'wheel' group - \n"
useradd -mg wheel $u_name

printf "\n - Setting your password - \n"
passwd $u_name
clear

printf " - Correct /etc/sudoers entries - \n"
nano /etc/sudoers
clear

printf " - Creating your home meta-folders (Documents, Pictures, etc.) - \n"
mkdir -p /home/$u_name/Documents
mkdir -p /home/$u_name/Pictures
mkdir -p /home/$u_name/Videos
mkdir -p /home/$u_name/Downloads
mkdir -p /home/$u_name/Music
mkdir -p /home/$u_name/Software
mkdir -p /home/$u_name/.fonts
ls -al /home/$u_name/

printf "\n\n - Ready to reboot and finish the final step! - \n"
