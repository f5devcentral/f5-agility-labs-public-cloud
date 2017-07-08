#!/bin/bash

# update packages
apk update

#install jq
apk add jq

#install openssl
apk add openssl

#install ab
apk add apache2-utils

#install gnupg
apk add gnupg

#install terraform
curl -O https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip
unzip terraform_0.9.11_linux_amd64.zip
mv terraform ./usr/local/bin/
terraform --version

#install aws-cli
pip install --upgrade --user awscli
export PATH=~/.local/bin:$PATH > ~/.bash_profile
source ~/.bash_profile
aws --version

git clone https://github.com/TonyMarfil/marfil-f5-terraform
cd ./marfil-f5-terraform/

source ./addUser

/*
gpg --output encrypted.data --symmetric --cipher-algo AES256 un_encrypted.data
gpg --output un_encrypted.data --decrypt encrypted.data
*/
