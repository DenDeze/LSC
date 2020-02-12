Deur contact Tasmota setup:

via Termite met behulp van de usb naar TTL converter (zie wiki tasmota)*:
Backlog ssid1 voorbeeldssid; password1 voorbeeldpsw; ssid2 ; password2




In de console van Tasmota zodra het deur contact wifi connectie heeft:
Backlog mqtthost 192.168.2.11; mqttuser ; mqttpassword ; topic huis/pir; otaurl http://thehackbox.org/tasmota/release/tasmota.bin
module 54
backlog TuyaMcu 11,1; TuyaMcu 51,51; TuyaMcu 12,3
rule1 ON Wifi#Connected DO backlog serialsend5 55 AA 00 01 00 00 00; delay 10; serialsend5 55 AA 00 02 00 01 04 06; delay 3; serialsend5 55 AA 00 05 00 01 00 05; ENDON
rule2 ON TuyaReceived#Data=55aa000200000155aa0005000501040001000f DO POWER ON; delay 1; DO POWER OFF ENDON
restart 1



*:https://github.com/arendst/Tasmota/wiki/Initial-Configuration#using-serial-terminal
