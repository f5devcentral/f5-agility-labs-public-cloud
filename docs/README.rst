Provision an AWS/F5 lab environment in an isolated VPC with Terraform
=====================================================================

Prerequisites:
--------------
Install git
Install terraform
Install AWS CLI
Create AWS User and generate Access key Id and Secrete Access key.
Generate 2 x BigIP Evaluation keys for: F5-BIG-VE-BT-25M-V13-LIC


1. Create AWS User and generate Access key Id and Secrete Access key.
Services -> Security, Identity & Compliance ->  IAM -> Users -> "Add user"
Check to enable Access type* : Programmatic access
Attach existing policies directly : AdministratorAccess.

.. note:: text
You almost certainly don't need AdministratorAccess. We'll lock down permissions later.

"Next: Review"
"Create user"
Copy and save the Access key Id to a text file for later use.
Copy the Secret access key to a text file for later use.

2. Find F5 in the Marketplace and accept agreement.

Configure the AWS console with Access key ID, Secret access key and generate ssh keys.

aws configure

The command below should 
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text | out-file -encoding ascii -filepath MyKeyPair.pem

Drop to bash shell (Linux), powershell(Windows) or terminal(MacOS):

Download git repository and change to working directory.

.. code-block:: language
git clone https://github.com/TonyMarfil/marfil-f5-terraform
cd ./marfil-f5-terraform/

Check terraform version is the tested v0.9.6:

terraform --version
terraform v0.9.6

Export the AWS keys and BigIP license variables with the AWS keys and BigIP licenses you created earlier.

export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
export TF_VAR_licenseKey1=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
export TF_VAR_licenseKey2=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

terraform plan
terraform apply

Go make yourself an espresso and come back in 10 minutes...

Whend done you should see a message like the one below.

Outputs:

bigipExternalSecurityGroup = sg-xxxxxxxx
bigipManagementSecurityGroup = sg-xxxxxxxx
elb_dns_name = terraform-asg-example-xxxxxxxxx.us-east-1.elb.amazonaws.com
licenseKey1 = XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
licenseKey2 = XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
managementSubnetAz1 = subnet-xxxxxxxx
managementSubnetAz2 = subnet-xxxxxxxx
restrictedSrcAddress = 0.0.0.0/0
sshKey = MyKeyPair
vpc-id = vpc-xxxxxxxx
vpc-private-d = 10.0.100.0/24
vpc-private-d-id = subnet-xxxxxxxx
vpc-private-e = 10.0.100.0/24
vpc-private-e-id = subnet-xxxxxxxx
vpc-public-d = 10.0.1.0/24
vpc-public-d-id = subnet-xxxxxxxx
vpc-public-e = 10.0.1.0/24
vpc-public-e-id = subnet-xxxxxxxx

Terraform has successfully done it's job, but we still have to wait for instances to spin up. Log back in to the AWS Console to track status of the new instances.

Two environments were created within a new VPC.
Environment one is an ELB load-balancing across two availability zones. You can test with the elb_dns_name in the terraform output.

terraform output | grep elb_dns_name
elb_dns_name = terraform-asg-example-xxxxxxxxx.us-east-1.elb.amazonaws.com
curl http://terraform-asg-example-xxxxxxxxx.us-east-1.elb.amazonaws.com
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    13  100    13    0     0    209      0 --:--:-- --:--:-- --:--:--   282Hello, World


Environment two is the "BIG-IP in AWS - Clustered 2-NIC across Availability Zones" up on GitHub with six web server instances across two Availability Zones (three web servers per AZ).
https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/cluster/2nic/across-az-ha

.. note:: text
"Autoscaling the BIG-IP Web Application Firewall in AWS" is a good fit for a next attempt:
https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/solutions/autoscale/waf/

AWS Console -> Services -> EC2 -> Running Instances.
Note the IPv4 Public IP addresses for the two instances named: "Big-IP: f5-cluster"

Highlight the primary Big-IP : f5-cluster. In the Description tab, note the Secondary private IP. This is the IP to be assigned to the virtual server we will soon configure.
Highlight the second Big-IP : f5-cluster. In the Description tab, note the Secondary private IP. This is the IP to be assigned to the virtual server we will soon configure.

Use the MyKeyPair.pem to ssh to both BigIP VEs.

Create an admin password so you can login to the WebUI.R

modify auth user admin shell bash
modify auth user admin password xxxxxxxx

Login to the BigIP WebUI.

The "HA_Across_AZs" iApp will already be deployed in the Common partition.

Download the latest iApp package from https://downloads.f5.com. I tested with iapps-1.0.0.455.0.zip.

Extract \iapps-1.0.0.455.0\TCP\Release_Candidates\f5.tcp.v1.0.0rc2.tmpl. This is the tested version of the iApp.

Import f5.tcp.v1.0.0rc2.tmpl to the primary BigIP. The secondary BigIP should pick up the configuration change automatically.

Deploy an iApp using the f5.tcp.v1.0.0rc2.tmpl template.

Template Selection: Advanced
Traffic Group: UNCHECK "Inherit traffic group from current partition / path"
Name: vs1

High Availability
What IP address do you want to use for the virtual server? Secondary private IP address of the first BigIP.

What is the associated service port? HTTP(80)

What IP address do you wish to use for the TCP virtual server in the other data center or availability zone? Secondary private IP address of the second BigIP.

Which servers are part of this pool? Private IP address of web-az1.0-2 and web-az2.0-2. Port: 8080.

Finished!

Login to the other BigIP WebUI and confirm the changes are in sync.

Confirm the virtual server is up!

curl http://52.205.85.86


StatusCode        : 200
StatusDescription : OK
Content           : Hello, World

RawContent        : HTTP/1.0 200 OK
                    Connection: close
                    Accept-Ranges: bytes
                    Content-Length: 13
                    Content-Type: text/html
                    Date: Wed, 07 Jun 2017 15:48:57 GMT
                    Last-Modified: Wed, 07 Jun 2017 14:42:59 GMT

                    Hello, World...
Forms             : {}
Headers           : {[Connection, close], [Accept-Ranges, bytes], [Content-Length, 13], [Content-Type, text/html]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 13

Stop the active BigIP instance and three web-az1.x instances in AZ1 via the AWS console and the elastic IP will 'float' over to the second BigIP.