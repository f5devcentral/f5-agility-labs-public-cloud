# static duplicate keys until I sort out BigIQ license manager
# export TF_VAR_licenseKey1=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
# export TF_VAR_licenseKey2=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
# export TF_VAR_bigiqLicense=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
export AWS_ACCESS_KEY_ID=`cat aws_accesskeys_$emailid.json | jq --raw-output .AccessKey.AccessKeyId`
export AWS_SECRET_ACCESS_KEY=`cat aws_accesskeys_$emailid.json | jq --raw-output .AccessKey.SecretAccessKey`
export TF_VAR_terraform_aws_vpc=terraform-vpc-${emailid}
export TF_VAR_aws_keypair=MyKeyPair-${emailid}
export TF_VAR_emailid=${emailid}
export TF_VAR_emailidsan=`echo $emailid | sed 's/[\@._-]//g'`
