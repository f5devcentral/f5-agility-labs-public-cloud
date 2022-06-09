Consul-Terraform-Sync 
==========================

Once all infrastructure is deployed, you can use Consul-Terraform-Sync to monitor the changes in your
NGINX instances and modify your F5 BigIP configuration accordingly, without the need for a network operator.

First, move into the ``nia`` directory in the repository.
 
.. code-block:: bash
   
   cd ../nia/

- Next, you will configure Consul-Terraform-Sync.

If you deployed the infrastructure using the provided scripts, the configuration file 
is produced automatically for you under the ``nia`` folder.

- Look at your configuration file to learn **Note** Don't use or copy this file
  This is just to show you how your file might look

.. code-block:: bash
   
    config.hcl 

    driver "terraform" {
    log = true
    required_providers {
      bigip = {
      source = "F5Networks/bigip"
       }
     }
    }
    #log_level = "trace"
    consul {
    address = "3.86.229.209:8500"
     }

    terraform_provider "bigip" {
        address  = "52.44.244.96:8443"
        username = "admin"
        password = "L5l81KPsxv"
     }

    task {
    name = "AS3"
    description = "BIG-IP example"
    source = "./bigip-example"
    providers = ["bigip"]
    services = ["nginx"]
     }

- Finally, you can start Consul-Terraform-Sync.

.. code-block:: bash

   consul-terraform-sync -config-file config.hcl

.. code-block:: bash

   ...
    [INFO] (cli) running controller in daemon mode
    [INFO] (cli) setting up controller: readwrite
    [INFO] (ctrl) initializing Consul client and testing connection
    [INFO] (cli) initializing controller
    [INFO] (ctrl) initializing driver
    [INFO] (ctrl) initializing all tasks
    [INFO] (client.terraformcli) Terraform logging is set, Terraform logs will output with Sync logs
    [INFO] (driver.terraform) retrieved 0 Terraform handlers for task 'AS3'
    [INFO] (templates.tftmpl) overwriting providers.tfvars in root module for task "AS3"
    [INFO] (templates.tftmpl) overwriting main.tf in root module for task "AS3"
    [INFO] (templates.tftmpl) overwriting variables.tf in root module for task "AS3"
    [INFO] (templates.tftmpl) overwriting terraform.tfvars.tmpl in root module for task "AS3"
    [INFO] running Terraform command: ./f5-terraform-consul-sd-webinar/nia/terraform version -json
    {
    "terraform_version": "0.13.7",
    "terraform_revision": "",
    "provider_selections": {
        "registry.terraform.io/f5networks/bigip": "1.8.0"
    },
    "terraform_outdated": true
    }

    [INFO] running Terraform command: ./f5-terraform-consul-sd-webinar/nia/terraform init -no-color -force-copy -input=false -lock-timeout=0s -backend=true -get=true -upgrade=false -lock=true -get-plugins=true -verify-plugins=true
    Initializing modules...

    Initializing the backend...

    Initializing provider plugins...
    - Using previously-installed f5networks/bigip v1.8.0

    Terraform has been successfully initialized!
    [INFO] running Terraform command: ./f5-terraform-consul-sd-webinar/nia/terraform workspace new -no-color AS3
    Workspace "AS3" already exists
    [INFO] running Terraform command: ./f5-terraform-consul-sd-webinar/nia/terraform workspace select -no-color AS3
    [INFO] running Terraform command: ./f5-terraform-consul-sd-webinar/nia/terraform validate -no-color -json
    {
    "valid": true,
    "error_count": 0,
    "warning_count": 0,
    "diagnostics": []
    }
    [INFO] (ctrl) driver initialized
    [INFO] (ctrl) executing all tasks once through
    [INFO] (ctrl) executing task AS3
    [INFO] running Terraform command: ./f5-terraform-consul-sd-webinar/nia/terraform apply -no-color -auto-approve -input=false -var-file=terraform.tfvars -var-file=providers.tfvars -lock=true -parallelism=10 -refresh=true
    Acquiring state lock. This may take a few moments...
    module.AS3.bigip_event_service_discovery.event_pools["nginx"]: Refreshing state... [id=~Consul_SD~Nginx~nginx_pool]
    module.AS3.bigip_event_service_discovery.event_pools["nginx"]: Modifying... [id=~Consul_SD~Nginx~nginx_pool]
    module.AS3.bigip_event_service_discovery.event_pools["nginx"]: Modifications complete after 1s [id=~Consul_SD~Nginx~nginx_pool]

    Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
    Releasing state lock. This may take a few moments...
    [INFO] (ctrl) task completed AS3
    [INFO] (ctrl) all tasks completed once
    [INFO] (api) starting server at '8558'
    ...


.. toctree::
   :maxdepth: 1
   :glob:

   lab*
