# install asl3 and allmon3

apt update && apt upgrade
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
./AllScanInstallUpdate.php
