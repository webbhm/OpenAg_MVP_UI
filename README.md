# OpenAg_MVP_UI
Interface code for the MVP data - graphs of temp, humidity, etc
  - Extract OpenAg_MVP_UI to the Pi directory
  - Move the web directory to Documents/OpenAg_MVP/
## The UI is composed of several scripts and files

  - index.html is a tabed web page for displaying data.  The code is simple and can be hacked to add more tabs and additional features
  The web server is needed to make things accessible over the web, it should be started every time the Raspberry Pi is booted.
  - server_8000.py starts a simple Python web server.  NOTE: do not run this file to start the server, instead run the bash script (startServer.sh) as the python file must be run from the directory from which the files are to be served.
  
  - The scripts collect and move the data to the web directory for access by the server
  - webcam.sh takes the pictures
  - render.sh moves the latest picture to the web directory, and generates the charts from CouchDB data 
  
## Setup

### Configure the server:
Ignore this for now.  I am having trouble getting rc.local to work, so for now just run the start script from the command line:

```bash ~/MVP_UI/scripts/startServer.sh```

logs & errors will go to: ~/MVP_UI/server.log

   - You want the server to start every time the Raspberry is re-booted or plugged in;therefore, you want to add this script to a start up file.  See the [instructions here](https://www.raspberrypi.org/documentation/linux/usage/rc-local.md) for adding this shell script to the /etc/rc.local filehttps://www.maketecheasier.com/run-bash-commands-background-linux/), and [here](https://www.maketecheasier.com/run-bash-commands-background-linux/) for running background.

```nohup bash startServer.sh &>/dev/null &```

The & is necessary to have the process run in background, else it will not let your startup process finish.
NOTE: This is going through some dynamic changes.  In order to enable IoT capabilities we are looking at switching to [lighttpd](http://redmine.lighttpd.net/projects/lighttpd) as a web server instead of Python's simpleHTTPServer.  Feel free to try this out, but be warned that we may rip it out in the future (by the end of July) and put something else in its place.  Hopefully we can do so without a lot of impact, and add a lot of new features!
   
   
### Create the view document in CouchDB

To pull data from the database you need a view.  This is a specially named document in the data database.  Run the following command from the command line:

```curl -X PUT http://localhost:5984/mvp_sensor_data/_design/doc --upload-file /home/pi/MVP_UI/setup/view.txt```

### The following entries need to be added to the crontab file.

//This takes a picture one minute after the hour, for the hours of 6 to 22 (10pm)

//There is no need to take pictures when the lights are off

```1 6-22 * * * /home/pi/MVP_UI/scripts/webcam.sh```

//This moves the latest picture, and builds the charts

//It runs at 3 minutes after every hour.  The three minutes is to do the rendering after the picture has been taken

```3 * * * * /home/pi/MVP_UI/scripts/render.sh```
