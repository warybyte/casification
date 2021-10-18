#!/bin/bash
# Description:  
# Script to cURLs CAS Service Provider (SP) metadata used by CAS service profiles. 
#
# Usage:
# This is designed to run from CRONTAB if you want regular updates to your MetaData
# but don't want to define URLs in your Service Profiles.
#
# Append new CAS Service Profile Metadata links and metafile name to the array
# Ex. 
#          ...
#          "https://previous.example.com|example1.xml", # some description/change#/etc
#          "https://yournew.example.com|newsp1.xml" # this is your new sp metadata link and file name

# Note0: 
# The pipe "|" splits the actual URL and the name of file you want to call it. This file name
# needs to match whatever is in your CAS service profile metadata file path.

# Note1:
# Make sure you append a comma to the previous entry so the array doesn't get grumpy.

METALINKS=( 
            "https://sample1.example.com/sample1.xml|sample1.xml", # sample metadata
            "https://sample2.example.com/sample2.xml|sample2.xml" # more metadata
           );

for METAFILE in "${METALINKS[@]}";
do 
    TMPLINK=$(echo $METAFILE | awk -F '|' '{print $1}');
    TMPSPNAME=$(echo $METAFILE | awk -F '|' '{print $2}' | sed s/,//g);
    curl $TMPLINK -o "/etc/cas/metadata/$TMPSPNAME"; 
done
