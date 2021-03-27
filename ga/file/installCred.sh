#!/bin/bash

# # get client_secret.json
# echo "Paste the client_secret.json here:"
# read secret
# [ ! -z "$secret" ] && echo $secret > /root/client_secret.json

# echo ' '
# install credentials

/env/bin/google-oauthlib-tool \
	--client-secrets /root/file/client_secret_638044564124-jlc2o348mhkk1l0u0hkkag2utak4mvmo.apps.googleusercontent.com.json \
	--scope https://www.googleapis.com/auth/assistant-sdk-prototype \
	--save --headless

echo ' '
echo 'Credentials installed, reboot container'
