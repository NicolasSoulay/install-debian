#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade

#logiciels
sudo apt install thunderbird libreoffice firefox-esr

#package de base pour l'environnement de bureau
sudo apt install kitty picom lightdm nitrogen awesome rofi numlockx exa neofetch

#utilitaire
sudo apt install wget pulseaudio pavucontrol gh fd-find ninja-build gettext cmake unzip curl ripgrep clang xsel composer

#language scpecific
sudo apt install python3 python3-pip python3-venv gcc g++ php php-mysql php-curl php-common libapache2-mod-php php-cli

#authentification Github
gh auth login

#install et configuration de git credential manager
wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.1.2/gcm-linux_amd64.2.1.2.deb" -O gcm.deb
sudo dpkg -i gcm.deb
git config --global credential.credentialStore plaintext
git-credential-manager configure

#install de pynvim pour neovim
python3 -m venv .venv
source .venv/bin/activate
pip install pynvim

#on crée le dossier .config
mkdir .config

#commande pour créer tous les dossier de base de home
xdg-user-dirs-update

#on crée un dossier Dev
mkdir Dev

#on ajoute des lignes au .bashrc
echo 'shopt -s globstar' >> .bashrc
echo 'export PATH="$HOME/Scripts:$PATH"' >> .bashrc

#ajout des bash alias
mv ~/install-debian/.bash_aliases ~/.bash_aliases

#tous les fichier de config + les wallpapers
git clone https://github.com/NicolasSoulay/Scripts.git
cd Pictures
git clone https://github.com/NicolasSoulay/Wallpapers.git
cd ~/.config
git clone https://github.com/NicolasSoulay/nvim.git
git clone https://github.com/NicolasSoulay/kitty.git
git clone https://github.com/NicolasSoulay/awesome.git
cd ~

#on recupere les fonts sur github et on met a jour le cache
sudo rm -R ~/.local/share/fonts
mkdir ~/.local/share
cd ~/.local/share
git clone https://github.com/NicolasSoulay/fonts.git
cd ~
fc-cache -f -v

#installation de discord
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt install ./discord.deb

#install de spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

#install de neovim 0.9 depuis les sources
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.9
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
sudo rm -R neovim

#install de symfony
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli

#install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node
nvm install-latest-npm

#install de Angular CLI 
npm install -g @angular/cli

#install de java
wget "https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb" -O jdk.deb
sudo apt install jdk.deb

#update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo rm discord.deb
sudo rm gcm.deb
sudo rm jdk.deb
sudo apt update
sudo apt upgrade
sudo apt autoremove

