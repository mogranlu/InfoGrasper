## InfoGrasper
A really simple infoscreen cron solution for Raspberry Pi


## INSTALL HOW-TO:
1) Run the following commands:
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install fbi

-- CRON
-- 2) Type crontab -e, and insert the following three lines at the bottom of this file:

## Starts the kiosk (info display at 7:00 AM , and shuts it down at 23:59 (PM)
0 7 * * *	export FRAMEBUFFER=/dev/fb0 DISPLAY=:0 && sudo fbi -d /dev/fb0 -T 1 -autozoom -noverbose -timeout 15 /home/pi/Pictures/*/*
59 23 * * *	sudo kill $( ps aux | grep -v grep | grep fbi | awk '{ print $2 }' )

3) Copy the presentations as images (jpg or png) under /home/pi/Pictures/*/*
For example:


pi@infoskjerm1:~/Pictures $ tree
.
|── presentation 1
│   |── slide1.png
│   |── slide2.png
│   |── slide3.png
|── presentation 2
│   |── slide1.txt
│   |── slide2.png
│   |── slide3.png
│   |── slide4.png
|── presentation 3
    |── slide1.jpg
    |── slide2.jpg
    |── slide3.jpg
    |── slide4.jpg
    |── slide5.jpeg

TIP!: Microsoft PowerPoint lets you "Save As..." and save the entire presentation as a set of images


4) Run the presentation
a) Run the following command (from the CLI - command line interface, not the Raspbian GUI interface):
fbi -d /dev/fb0 -T 1 -autozoom -noverbose -timeout 15 /home/pi/Pictures/*/*


b) ...or wait until seven O' clock the next morning.



NB! Note that the system clock may be one hour "skewed" (late)!