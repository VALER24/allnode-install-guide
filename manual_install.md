# Guide to installing software on AllNode device

# Run updates and install allstarlink3, allmon3, & dvswitch

```
sudo -s
apt update && apt upgrade && apt install git
cd /tmp
wget https://repo.allstarlink.org/public/asl-apt-repos.deb12_all.deb
sudo dpkg -i asl-apt-repos.deb12_all.deb
sudo apt update
apt install asl3 && apt install allmon3

wget http://dvswitch.org/bookworm
chmod +x bookworm
./bookworm
apt update && apt install dvswitch-server
```

# Configure allstarlink

```
asl-menu (configure allstar, and make private node 1999 USRP)
```
# Delete /etc/asterisk/simpleusb.conf and then nano /etc/asterisk/simpleusb.conf and paste this:
```
;***************************************************
;********   Template-tized simpleusb.conf   ********
;***************************************************
; Note to editors: set tabs to 4 space characters. No wrap to keep comments neat.
; vim: tabstop=4
;
; SimpleUSB channel driver Configuration File
;
;;;;;                 New to ASL3                 ;;;;;
;;;;; The SimpleUSB "tune" settings have moved to ;;;;;
;;;;; this file. The simpleusb_tune_usb_1999.conf ;;;;;
;;;;; file is no longer used.                     ;;;;;

; If you are going to use this channel driver, you MUST enable it in modules.conf
; change:
; noload => chan_simpleusb.so       ; CM1xx USB Cards with Radio Interface Channel Driver (No DSP)
; noload => res_usbradio.so         ; Required for both simpleusb and usbradio
; to:
; load => chan_simpleusb.so         ; CM1xx USB Cards with Radio Interface Channel Driver (No DSP)
; load => res_usbradio.so           ; Required for both simpleusb and usbradio

[general]
;------------------------------ JITTER BUFFER CONFIGURATION --------------------------
; jbenable = yes              ; Enables the use of a jitterbuffer on the receiving side of an
                              ; simpleusb channel. Defaults to "no". An enabled jitterbuffer will
                              ; be used only if the sending side can create and the receiving
                              ; side can not accept jitter. The simpleusb channel can't accept jitter,
                              ; thus an enabled jitterbuffer on the receive simpleusb side will always
                              ; be used if the sending side can create jitter.

; jbmaxsize = 200             ; Max length of the jitterbuffer in milliseconds.

; jbresyncthreshold = 1000    ; Jump in the frame timestamps over which the jitterbuffer is
                              ; resynchronized. Useful to improve the quality of the voice, with
                              ; big jumps in/broken timestamps, usualy sent from exotic devices
                              ; and programs. Defaults to 1000.

; jbimpl = fixed              ; Jitterbuffer implementation, used on the receiving side of an simpleusb
                              ; channel. Two implementations are currenlty available - "fixed"
                              ; (with size always equals to jbmax-size) and "adaptive" (with
                              ; variable size, actually the new jb of IAX2). Defaults to fixed.

; jblog = no                  ; Enables jitterbuffer frame logging. Defaults to "no".
;-----------------------------------------------------------------------------------

[node-main](!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Template for all your SimpleUSB nodes ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

eeprom = 0
hdwtype = 0
rxboost = 0
carrierfrom = usbinvert
ctcssfrom = no
deemphasis = yes
plfilter = no
rxondelay = 5
rxaudiodelay = 10
txmixa = voice
txmixb = no
txboost = 0
invertptt = 0
preemphasis = yes
duplex = 0

;;; End of node-main template

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; Configure your nodes here ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Note: there is no need to duplicate entire settings. Only
;       place settings that are different than the template.
;
; Note: the device string is automatically found when the
;       USB setting "devstr=" is empty.
;
; Note: the interface "tune" settings will be added to the
;       per-node settings (below).

[XXXXX](node-main)
eeprom = 0
hdwtype = 0
rxboost = 0
carrierfrom = usbinvert
ctcssfrom = no
deemphasis = yes
plfilter = no
rxondelay = 5
rxaudiodelay = 10
txmixa = voice
txmixb = no
txboost = 0
invertptt = 0
preemphasis = yes
duplex = 0
;;;;; ASL3 Tune settings ;;;;;
devstr=
rxmixerset=500
txmixaset=500
txmixbset=500
```
# Configure allmon3 allnode.local/allmon3 (optional)
```
nano /etc/allmon3/allmon3.ini (make a simple password, can be same as everything else)
allmon3-passwd --delete allmon3
allmon3-passwd admin
nano /etc/asterisk/manager.conf (change 1999 to your node number and change the password, make sure this is 100% identical to the password you put in allmon3.ini)

systemctl start allmon3
systemctl status allmon3

if it doesn't work run the password commands again and/or reboot
```
# Install supermon and allscan allnode.local/allscan (optional)
```
cd ~
apt update && apt install apache2 php libapache2-mod-php libcgi-session-perl bc unzip -y
wget "http://2577.asnode.org:43856/supermonASL_fresh_install" -O supermonASL_fresh_install
chmod +x supermonASL_fresh_install
wget 'https://raw.githubusercontent.com/davidgsd/AllScan/main/AllScanInstallUpdate.php'
chmod 755 AllScanInstallUpdate.php
apt install unzip && apt install php
./AllScanInstallUpdate.php
```
# Configure echolink (optional)
```
nano /etc/asterisk/echolink.conf (change everything and use -L)
nano /etc/asterisk/modules.conf (change noload to load for the echolink module)
systemctl restart asterisk
```
# Configure private node 1999 for dvswitch (optional if skipping dvswitch) if you don't see 1999 section scroll to the bottom
```
nano /etc/asterisk/rpt.conf
```
```
rxchannel = USRP/127.0.0.1:34001:32001  ; Use the USRP channel driver. Must be enabled in modules.conf
; 127.0.0.1 = IP of the target application
; 34001 = UDP port the target application is listening on
; 32001 = UDP port ASL is listening on
duplex = 0
hangtime = 0
althangtime = 0
holdofftelem = 1
telemdefault = 0
telemdynamic = 0
linktolink = no
nounkeyct = 1
totime = 180000
```
# Setup DVSwitch (optional if skipping dvswitch)
```
cd /usr/local/dvs
./dvs (first configure dvswitch)

configure /opt/Analog_Bridge/Analog_Bridge.ini | /opt/MMDVM_Bridge/MMDVM_Bridge.ini

test switching talkgroups using these commands:

/opt/MMDVM_Bridge/dvswitch.sh mode YSF
/opt/MMDVM_Bridge/dvswitch.sh tune parrot.ysfreflector.de:42020
```
# Setup DVSwitch mode switcher (optional, but recommended)
```
sudo -s

apt update && apt upgrade && apt install git && apt install nodejs

cd /opt

git clone https://github.com/firealarmss/dvswitch_mode_switcher

cd dvswitch_mode_switcher

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.bashrc

nvm install 18

nvm use 18

cp configs/config.example.yml configs/config.yml

cp configs/tg_alias.example.yml configs/tg_alias.yml

npm install yargs path

npm i

node index.js -c configs/config.yml

***************IF ALL THINGS WORK**************

cd /opt/dvswitch_mode_switcher

cp debian/dvswitch_mode_switcher.service /etc/systemd/system/dvswitch_mode_switcher.service

systemctl daemon-reload

systemctl enable dvswitch_mode_switcher.service

systemctl start dvswitch_mode_switcher.service
```
Configure connection software (optional)
```
cd /opt
git clone https://github.com/valer24/allnode_software
cd allnode_software
npm install express body-parser child_process fs path https
npm i
cp debian/allnode_software.service /etc/systemd/system/allnode_software.service
systemctl daemon-reload
systemctl enable allnode_software
```
Setup startpage
```
cd /var/www/html
rm index.php
rm index.html
nano index.html
# PASTE IN the index.html file located in this repo
systemctl restart apache2
```
