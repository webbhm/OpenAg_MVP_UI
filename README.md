# OpenAg_MVP_UI
Interface code for the MVP data - graphs of temp, humidity, etc

## The UI is composed of several scripts and files

  - index.html is a tabed web page for displaying data.  The code is simple and can be hacked to add more tabs and additional features
  The web server is needed to make things accessible over the web, it should be started every time the Raspberry Pi is booted.
  - server_8000.py starts a simple Python web server.  NOTE: do not run this file to start the server, instead run the bash script (startServer.sh) as the python file must be run from the directory from which the files are to be served.
  
  - The scripts collect and move the data to the web directory for access by the server
  - webcam.sh takes the pictures
  - render.sh moves the latest picture to the web directory, and generates the charts from CouchDB data 
  
## Setup
  
  - Click on 'Clone or Download' button
  - Select 'Download Zip'.  This should download the repository to the Downloads directory.
  - Open a File Browser and go to the Downloads directory.
  - Right click on 'OpenAg_MVP_UI-master.zip, and select 'Extract Here'
  - Double click on the new directory 'OpenAg_MVP_UI-master to open it
  - Move the web directory to Documents/OpenAg_MVP/
  - Drag and drop the MVP_UI directory to the pi directory.
  
### Create the view document in CouchDB

To pull data from the database you need a view.  This is a specially named document in the data database.  Run the following command from the command line:

```curl -X PUT http://localhost:5984/mvp_sensor_data/_design/doc --upload-file /home/pi/MVP_UI/setup/view.txt```


### Install charting software  

  - Install pygal
  ```sudo pip install pygal```

### Configure the server:

I am still testing the stability of the server, so there are two versions here (depending on how adventurious you are)

The simple version starts the server from the command line, however you need to leave the terminal window open to keep the server running.  Messages will display in the window.  For this version, run:

```bash ~/MVP_UI/scripts/startServer2.sh```

  - To stop the server, press Ctl-C
  
  The second version runs the server in 'background' and will restart automatically every time the Raspberry is rebooted.  To do this you need to edit the file /etc/rc.local and all a line to start the server.
  
    - Open a terminal window
    - Type:
    ```cd /etc```
    ```sudo leafpad rc.local```
    
    - scroll to just above the line that says "exit 0" (this should be the last line) and type:
    
    ```bash /home/pi/MVP_UI/scripts/startServer.sh```
    
   - See the [instructions here](https://www.raspberrypi.org/documentation/linux/usage/rc-local.md) for adding this shell script to the /etc/rc.local filehttps://www.maketecheasier.com/run-bash-commands-background-linux/), and [here](https://www.maketecheasier.com/run-bash-commands-background-linux/) for running background.

  - logs & errors will go to: ~/MVP_UI/server.log

### The following entries need to be added to the crontab file.

//This moves the latest picture, and builds the charts

//It runs at 3 minutes after every hour.  The three minutes is to do the rendering after the picture has been taken

```3 * * * * /home/pi/MVP_UI/scripts/render.sh```
