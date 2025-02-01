# Autoinstall everything with script

# Install everything with script

```
sudo -s
cd /tmp
nano script.sh (paste in the script.sh in this repo)
chmod +x script.sh
./script.sh
```

# Configure allstarlink

`asl-menu`

Go and add your node number, callsign, number, password, etc. Add private node 1999 USRP half-duplex.

`rm /etc/asterisk/simpleusb.conf`

`nano /etc/asterisk/simpleusb.conf`

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
# Configure echolink (optional)
```
nano /etc/asterisk/echolink.conf (change everything and use -L)
nano /etc/asterisk/modules.conf (change noload to load for the echolink module)
systemctl restart asterisk
```
# Configure allmon3 allnode.local/allmon3 (optional)
```
nano /etc/allmon3/allmon3.ini (make a simple password, can be same as everything else)
allmon3-passwd --delete allmon3
allmon3-passwd admin
nano /etc/asterisk/manager.conf (uncomment and change 1999 to your node number and change the password, make sure this is 100% identical to the password you put in allmon3.ini)

systemctl start allmon3
systemctl status allmon3

if it doesn't work run the password commands again and/or reboot
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
# Test dvswitch_mode_switcher and allnode software
```
systemctl start dvswitch_mode_switcher
systemctl start allnode_software
```
# Setup startpage
```
cd /var/www/html
rm index.php
rm index.html
nano index.html
# PASTE IN the index.html file located in this repo
systemctl restart apache2
```
# Go to allnode.local/allscan and create username/password
