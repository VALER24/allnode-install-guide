# allstar

```
sudo -s
apt update && apt upgrade
apt install allmon3 && apt install git

wget http://dvswitch.org/bookworm
chmod +x bookworm
./bookworm
apt update
apt install dvswitch-server

asl-menu (configure allstar)
nano /etc/asterisk/simpleusb.conf
```

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
