printf "\n - Alright big boy, time to get going - \n"
printf "\n - Installing 'yay', an AUR package manager - \n"
cd Software
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
clear
cd ~/Software
git clone https://github.com/wvanis3/archie.git
cd archie
mv *.ttf ~/.fonts

printf "\n - Updating font cache - \n"
fc-cache -fv
clear
printf "\n -  - \n"
printf "\n - Installing AUR packages - \n"
yay -S spotify --noconfirm
yay -S visual-studio-code-bin --noconfirm
clear

printf " - You're all set! - \n"
