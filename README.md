## LSC
LSC action devices tasmota


Wiki om LSC PIR en LSC deurcontacten zoals te koop bij de action van een nieuwe firmware te voorzien zodat deze kunnen communiceren met een MQTT broker.



## Benodigdheden om de chip van nieuwe firmware te voorzien:
1.USB naar TTL converter  
2.soldeerbout  
3.termite (software)  

4.Pyflasher (GUI wrapper voor esptool.py):  
   https://github.com/arendst/Tasmota/wiki/Flashing#tasmota-pyflasher   

5.wiki link:  
   https://github.com/DenDeze/LSC/wiki   


## project
Om de LSC modules van nieuwe firmware te voorzien is het aan te raden op de TYWE3S module te solderen.
![](https://hack42.nl/mediawiki/images/thumb/6/69/Tywe3s.png/300px-Tywe3s.png)

de volgende aansluitingen zijn noodzakelijk om te kunnen flashen:
 *  rx
 *  tx
 *  io0
 *  gnd
 *  vcc

Met als resultaat:

![deur sensor](https://github.com/DenDeze/LSC/blob/master/IMG_8658.JPG?raw=true)  

![pir](https://github.com/DenDeze/LSC/blob/master/IMG_8663.JPG?raw=true)  

Om te kunnen flashen is de usb naar TTL converter nodig, connecteer io0 naar gnd om de module in flash modus te krijgen.
Connecteer als laatste de 3,3V. Hierdoor start de module op (zonder batterijen).
download de laatste tasmota firmware (tasmota.bin):
http://thehackbox.org/tasmota/release/

zodra de module spanning heeft start je py flasher op en laad je het tasmota.bin bestand.  

![](https://github.com/DenDeze/LSC/blob/master/Knipsel2.PNG?raw=true)  


Na het flashen kan de usb naar ttl connector uitgetrokken worden.  

Hierop is het handig om de batterijen te plaatsen in de module.
Na het plaatsen van de batterijen op de knop achter op het device drukken waardoor deze tasmota opstart, aangezien de tuya chip maar even opstart is het aan te raden de usb naar ttl converter weer in te steken zodat de ESP chip continu spanning krijgt om de configuratie af te maken.

Start termite op en volg de stappen 1 of 2 afhankelijk van het LSC device.  

![](https://github.com/DenDeze/LSC/blob/master/Knipsel3.PNG?raw=true)  

# Deur contact Tasmota setup:

via Termite met behulp van de usb naar TTL converter ([wiki tasmota](https://github.com/arendst/Tasmota/wiki/Initial-Configuration#using-serial-terminal))*:
> Backlog ssid1 mijnrouter; password1 supergeheim; ssid2 ; password2

ga naar http://192.168.1.2 (afhankelijk van het ip adres dat zichtbaar is in termite):

> Backlog mqtthost 192.168.2.11; mqttuser ; mqttpassword ; topic huis/deur; otaurl http://thehackbox.org/tasmota/release/tasmota.bin

> module 54

> backlog TuyaMcu 11,1; TuyaMcu 51,51; TuyaMcu 12,3

> rule1 ON Wifi#Connected DO backlog serialsend5 55 AA 00 01 00 00 00; delay 10; serialsend5 55 AA 00 02 00 01 04 06; delay 3; serialsend5 55 AA 00 05 00 01 00 05; ENDON

> rule2 ON TuyaReceived#Data=55aa000200000155aa0005000501010001010d DO POWER ON ENDON

> rule3 ON TuyaReceived#Data=55aa000200000155aa0005000501010001000c DO POWER OFF ENDON

> restart 1

# PIR Tasmota setup:

via Termite met behulp van de usb naar TTL converter ([wiki tasmota](https://github.com/arendst/Tasmota/wiki/Initial-Configuration#using-serial-terminal)):

> Backlog ssid1 voorbeeldssid; password1 voorbeeldpsw; ssid2 ; password2

ga naar http://192.168.1.2 (afhankelijk van het ip adres dat zichtbaar is in termite):
open de console

> Backlog mqtthost 192.168.2.11; mqttuser ; mqttpassword ; topic huis/pir; otaurl http://thehackbox.org/tasmota/release/tasmota.bin

> module 54

> backlog TuyaMcu 11,1; TuyaMcu 51,51; TuyaMcu 12,3

> rule1 ON Wifi#Connected DO backlog serialsend5 55 AA 00 01 00 00 00; delay 10; serialsend5 55 AA 00 02 00 01 04 06; delay 3; serialsend5 55 AA 00 05 00 01 00 05; ENDON

> rule2 ON TuyaReceived#Data=55aa000200000155aa0005000501040001000f DO POWER ON; delay 1; DO POWER OFF ENDON

> restart 1

