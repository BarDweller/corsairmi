corsaiRMi
=========
Minimal program for Linux to read monitoring information out of Corsair RMi series of PSUs, and push the data to ThingSpeak.
Uses Linux HIDRAW interface.
Tested on Corsair RM750i.

Compiling
---------
- Register for a ThingSpeak channel at http://thingspeak.com/
- Obtain the "Write API Key" from the Thingspeak channel 'API Keys' tab.
- Edit the corsairmi.c and add the key around line 72 as the value for the char* `thingspeakapikey`
 - Eg. `static char* thingspeakapikey = "4FRG9N5PECMDHK34";`

You need libcurl dev available, on ubuntu `apt-get install libcurl4-openssl-dev` will be enough.

Beyond libcurl, there are basically no dependencies..
Compile using `make`

Usage
-----
`./corsairmi [/dev/hidrawN]`

To automate, add this line to /etc/crontab, then every minute a push will be made to ThingSpeak.

`*  *    * * *   root    /path/to/where/you/put/corsairmi`

Ubuntu 16.04 notes
------------------

Ubuntu wouldnt' create the /dev/hidraw device required for this tool to work until udev was told to create it.
Create a file called `/etc/udev/rules.d/50-usb-psu.conf`
With the content..
```
SUBSYSTEM=="usb", ATTRS{busnum}=="1", ATTRS{idVendor}=="1b1c", MODE="0666"
KERNEL=="hiddev*", ATTRS{idVendor}=="1b1c", MODE="0666"
```
Which will enable the hidraw device for the usb device with vendor id 1b1c (which matches my rm750i psu)

TODO
----
- allow key to be an argument
- allow sysout, or push to be selected using args
