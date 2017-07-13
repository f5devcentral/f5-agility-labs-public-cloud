#!/bin/bash

#install ab
apk add apache2-utils

#install gettext
apk add gettext

#install jq
apk add jq

#install openssl
apk add openssl

#install wget
apk add wget

#install terraform
curl -O https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip
unzip ./terraform_0.9.11_linux_amd64.zip
mv ./terraform /usr/local/bin/
echo "terraform --version"
echo `terraform --version`

#install aws-cli

pip install --upgrade --user awscli
mkdir ~/.aws/
export PATH=~/.local/bin:$PATH
export AWS_CONFIG_FILE=~/.aws/config
echo "aws --version"
echo `aws --version`

echo "Enter decryption password:
"
read decryptPassword

cd ~/.aws/ && { curl -O https://s3.amazonaws.com/f5-marfil/config.enc ; cd -; }
openssl aes-256-cbc -d -a -in ~/.aws/config.enc -out ~/.aws/config -pass pass:$decryptPassword

cp ./scripts/.profile ~/.profile

source ./scripts/addUser.sh

# encrypt
# openssl aes-256-cbc -a -salt -in config -out config.enc
