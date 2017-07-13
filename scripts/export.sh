#!/bin/bash

if [ -f *.emailid ]; then 
export emailid=$(basename `ls *.emailid` .emailid);
echo "emailid exists and is ${emailid}";
else echo "Zero or multiple emailids! Something went wrong."
fi
export AWS_ACCESS_KEY_ID=`cat aws_accesskeys_${emailid}.json | jq --raw-output .AccessKey.AccessKeyId`
export AWS_SECRET_ACCESS_KEY=`cat aws_accesskeys_${emailid}.json | jq --raw-output .AccessKey.SecretAccessKey`
export TF_VAR_terraform_aws_vpc=terraform-vpc-${emailid}
export TF_VAR_aws_keypair=MyKeyPair-${emailid}
export TF_VAR_emailid=${emailid}
export TF_VAR_emailidsan=`echo ${emailid} | sed 's/[\@._-]//g'`

# broken
# export TF_VAR_aws_alias=https://`aws iam list-account-aliases | jq --raw-output .AccountAliases[]`.signin.aws.amazon.com/console

#alternate way to export account alias to TF_VAR_aws_alias

aliasprefix=f5agility2017
emailidsan=`echo $emailid | sed 's/[\@._-]//g'`
alias=${aliasprefix}${emailidsan}
export TF_VAR_aws_alias=https://$alias.signin.aws.amazon.com/console
