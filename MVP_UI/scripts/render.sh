#!/bin/bash

#This script renders the web data files
#Invoke this via cron on a regular (hourly?) basis to refresh the data
#Author: Howard Webb
#Date: 7/5/2017

echo "Move latest webcam image"

#Modify this path if you move the webcam image directory
in_dir="/home/pi/Documents/OpenAg-MVP/webcam/"
out_dir="/home/pi/Documents/OpenAg-MVP/web/"

#Pipe ls of the webcam directory from most recent to latest
# Then clip off only the last line
# Finally trim the string to just the name and store in the variable (File Name)
FN=$(ls -latr "$in_dir" | tail -1 | awk '{print $NF}')

#Check that got what expected
echo "$in_dir$FN"

#Finally copy this file to the output web directory
#Since will be overwriting, need to confirm with "yes"
yes | cp "$in_dir$FN" "$out_dir"image.jpg


#create the temperature graph
echo "Build temperature graph"
python /home/pi/MVP_UI/python/temp_chart.py

echo "Build humidity graph"
#create the humidity graph
python /home/pi/MVP_UI/python/humidity_chart.py