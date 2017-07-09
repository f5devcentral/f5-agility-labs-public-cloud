#/bin/bash

echo "Enter an email address:
"
read -n 20 emailid

if [ -f "./aws_accesskeys_${emailid}.json" ]; then 
    echo "Account exists. Exporting shell variables.
"
. ./scripts/export.sh
else
    
echo "Enter an aws console password:
"
read awsConsolePass

aliasprefix=f5agility2017
emailidsan=`echo $emailid | sed 's/[\@._-]//g'`
alias=${aliasprefix}${emailidsan}
groupName=aws-full-access

# create user

aws iam create-user \
--path "/" \
--user-name "$emailid"

# add user to admins group

aws iam add-user-to-group --user-name $emailid --group-name $groupName

# create access key

aws iam create-access-key --user-name "$emailid" | tee aws_accesskeys_$emailid.json

# create console login

aws iam create-login-profile \
--user-name "$emailid" \
--password "$awsConsolePass"

# create account alias

aws iam create-account-alias \
--account-alias "$alias"

# get user info

aws iam get-user \
--user-name "$emailid"

# get user policies

aws iam list-user-policies \
--user-name "$emailid"

# create ssh keys and store private key locally

aws ec2 create-key-pair --key-name MyKeyPair-${emailid} --query 'KeyMaterial' --output text > MyKeyPair-${emailid}.pem
chmod 400 MyKeyPair-${emailid}.pem

#create a self-signed SSL certificate

openssl req -subj '/O=test LTD./CN=f5.io/C=US' -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout ${emailidsan}.key -out ${emailidsan}.crt -nodes

# export environment variables for use by terraform

. ./scripts/export.sh

fi
