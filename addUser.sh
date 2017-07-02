#/bin/bash

echo "Enter an email address:
"
read emailid

echo "Enter an aws console password:
"
read awsConsolePass

aliasprefix=f5agility2017
alias=$aliasprefix`echo $emailid | sed 's/[\@._-]//g'`

# create user

aws iam create-user \
--path "/" \
--user-name "$emailid"

# add user to admins group

aws iam add-user-to-group --user-name $emailid --group-name admins

# create access key

aws iam create-access-key --user-name "$emailid" | tee aws_accesskeys.json

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

# export environment varibales for use by terraform

. ./export.sh
