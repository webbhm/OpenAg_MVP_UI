#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")

fswebcam -r 1280x720 --no-banner /home/pi/Documents/OpenAg-MVP/webcam/$DATE.jpg