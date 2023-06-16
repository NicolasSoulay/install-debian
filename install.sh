#!/usr/bin/bash
cd ~

sudo apt update
sudo apt upgrade
sudo dpkg --add-architecture i386
sudo apt update

#logiciels
sudo apt install thunderbird libreoffice firefox-esr gimp steam

#package de base pour l'environnement de bureau
sudo apt install kitty picom lightdm nitrogen awesome rofi numlockx exa neofetch

#utilitaire
sudo apt install wget pulseaudio pavucontrol gh fd-find ninja-build gettext cmake unzip curl ripgrep clang xsel composer

#language scpecific
sudo apt install gcc g++ python3 python3-pip python3-venv php php-mysql php-curl php-common libapache2-mod-php php-cli php-xml mariadb-server mariadb-client

#install et configuration de git credential manager
wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.1.2/gcm-linux_amd64.2.1.2.deb" -O gcm.deb
sudo dpkg -i gcm.deb
git config --global credential.credentialStore plaintext
git-credential-manager configure

#Compte default git
git config --global user.email "soulaynicolas@gmail.com"
git config --global user.name "NicolasSoulay"
git config --global init.defaultBranch main

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
mkdir ~/.local
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

#install de pynvim pour neovim
sudo apt install python3-pynvim

#install de symfony
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli

#install de NodeJs et NPM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node # TODO il faut que je reload le terminal ou le shell à ce point la, sinon il connais pas encore la commande nvm, ou alors faut que je lui donne le chemin vers la commande
nvm install-latest-npm

#install de Angular CLI 
npm install -g @angular/cli

#dependances neovim
npm install -g neovim

#install de java
wget "https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb" -O jdk.deb
sudo apt install ./jdk.deb

#config java
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-20/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-20/bin/javac 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-20/bin/jar 1
sudo update-alternatives --install /usr/bin/javadoc javadoc /usr/lib/jvm/jdk-20/bin/javadoc 1

sudo update-alternatives --config java
sudo update-alternatives --config javac
sudo update-alternatives --config jar
sudo update-alternatives --config javadoc

touch ~/jdk.sh
sudo echo "export J2SDKDIR=/usr/lib/jvm/jdk-20">> ~/jdk.sh
sudo echo "export J2REDIR=/usr/lib/jvm/jdk-20">> ~/jdk.sh
sudo echo "export PATH=\$PATH:/usr/lib/jvm/jdk-20/bin:/usr/lib/jvm/jdk-20/db/bin">> ~/jdk.sh
sudo echo "export JAVA_HOME=/usr/lib/jvm/jdk-20">> ~/jdk.sh
sudo echo "export DERBY_HOME=/usr/lib/jvm/jdk-20/db">> ~/jdk.sh
sudo mv jdk.sh /etc/profile.d/jdk.sh

touch ~/jdk.csh
sudo echo"setenv J2SDKDIR /usr/lib/jvm/jdk-20">> ~/jdk.csh
sudo echo"setenv J2REDIR /usr/lib/jvm/jdk-20">> ~/jdk.csh
sudo echo"setenv PATH \${PATH}:/usr/lib/jvm/jdk-19/bin:/usr/lib/jvm/jdk-20/db/bin">> ~/jdk.csh
sudo echo"setenv JAVA_HOME /usr/lib/jvm/jdk-20">> ~/jdk.csh
sudo echo"setenv DERBY_HOME /usr/lib/jvm/jdk-20/db">> ~/jdk.csh
sudo mv jdk.csh /etc/profile.d/jdk.csh

sudo chmod +x /etc/profile.d/jdk.csh /etc/profile.d/jdk.sh

#update final au cas ou, on remove des dependances obsoletes, on remove les fichier qui ne servent plus
sudo rm discord.deb
sudo rm gcm.deb
sudo rm jdk.deb
sudo apt update
sudo apt upgrade
sudo apt autoremove

