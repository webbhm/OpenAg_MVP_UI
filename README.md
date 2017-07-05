# OpenAg_MVP_UI
Interface code for the MVP data - graphs of temp, humidity, etc
  - Extract OpenAg_MVP_UI to the Pi directory
  - Move the web directory to Documents/OpenAg_MVP/
## The UI is composed of several scripts and files
  - index.html is a tabed web page for displaying data.  The code is simple and can be hacked to add more tabs and additional features
  The web server is needed to make things accessible over the web, it should be started every time the Raspberry Pi is booted.
  See the following for a simple way to start the server on boot:
  https://www.raspberrypi.org/documentation/linux/usage/rc-local.md
  - server_8000.py starts a simple Python web server
## The scripts collect and move the data to the web directory for access by the server
  - webcam.sh takes the pictures
  - render.sh moves the latest picture to the web directory, and generates the charts from CouchDB data 
  
## The following entries need to be added to the crontab file.

//This takes a picture one minute after the hour, for the hours of 6 to 22 (10pm)

//There is no need to take pictures when the lights are off

1 6-22 * * * /home/pi/MVP_UI/scripts/webcam.sh

//This moves the latest picture, and builds the charts

//It runs at 3 minutes after every hour.  The three minutes is to do the rendering after the picture has been taken

3 * * * * /home/pi/MVP_UI/scripts/render.sh