#!/bin/bash

# check for credentials.json
if [ -e /root/.config/google-oauthlib-tool/credentials.json ] ; then
	# run gassistant
	echo "Start GA"
	# /env/bin/googlesamples-assistant-pushtotalk --project-id gapy-59cfb  --device-model-id gapy-59cfb-rpy-cp812h
	#/env/bin/googlesamples-assistant-hotword --project-id gapy-59cfb  --device-model-id gapy-59cfb-rpy-cp812h
	
else
	echo " "
	echo "Credentials not installed"
	echo "Run '/file/installCred.sh' and reboot"
	# bash
	# exec /bin/bash
fi