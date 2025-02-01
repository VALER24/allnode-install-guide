#!/bin/bash

# install asl3 and allmon3

apt update && apt upgrade && apt install git
cd /tmp
wget https://repo.allstarlink.org/public/asl-apt-repos.deb12_all.deb
dpkg -i asl-apt-repos.deb12_all.deb
apt update && apt install asl3 && apt install allmon3

# install dvswitch

wget http://dvswitch.org/bookworm
chmod +x bookworm
./bookworm
apt update && apt install dvswitch-server

# install allscan

cd ~
wget 'https://raw.githubusercontent.com/davidgsd/AllScan/main/AllScanInstallUpdate.php'
chmod 755 AllScanInstallUpdate.php
apt install unzip
./AllScanInstallUpdate.php

# install dvswitch_mode_switcher

apt update && apt upgrade && apt install nodejs
cd /opt
git clone https://github.com/hquimby/dvswitch_mode_switcher
cd dvswitch_mode_switcher
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.bashrc
nvm install 18
nvm use 18
cp configs/config.example.yml configs/config.yml
cp configs/tg_alias.example.yml configs/tg_alias.yml
cp debian/dvswitch_mode_switcher.service /etc/systemd/system/dvswitch_mode_switcher.service
npm install yargs path
npm i
systemctl daemon-reload
systemctl enable dvswitch_mode_switcher.service

# install allnode software

cd /opt
git clone https://github.com/valer24/allnode_software
cd allnode_software
npm install express body-parser child_process fs path https
npm i
cp debian/allnode_software.service /etc/systemd/system/allnode_software.service
systemctl daemon-reload
systemctl enable allnode_software
