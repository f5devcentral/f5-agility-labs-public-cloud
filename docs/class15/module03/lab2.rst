Use Terraform scripts to deploy AS3 FAST template
===================================================

- Change directory to 

.. code-block:: bash

   $ cd ../fast

- First, initialize Terraform.

.. code-block:: bash

   $ terraform init

::

   Initializing the backend...

    Initializing provider plugins...
    - Finding f5networks/bigip versions matching "1.9.0"...
    - Finding latest version of hashicorp/archive...
    - Installing f5networks/bigip v1.9.0...
    - Installed f5networks/bigip v1.9.0 (signed by a HashiCorp partner, key ID 8D69F031B13946D3)
    - Installing hashicorp/archive v2.2.0...
    - Installed hashicorp/archive v2.2.0 (signed by HashiCorp)

    Partner and community providers are signed by their developers.
    If you'd like to know more about provider signing, you can read about it here:
    https://www.terraform.io/docs/plugins/signing.html

    The following providers do not have any version constraints in configuration,
    so the latest version was installed.

    To prevent automatic upgrades to new major versions that may contain breaking
    changes, we recommend adding version constraints in a required_providers block
    in your configuration, with the constraint strings suggested below.

    * hashicorp/archive: version = "~> 2.2.0"

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary. 

**Note:** Issue the command again if ``terraform init`` fails with Error: Failed to install provider.

- Then, use ``terraform plan`` to check the resources that are going to be created.

.. code-block:: bash

   $ terraform plan 

.. code-block:: bash

    ...
    Plan: 2 to add, 0 to change, 0 to destroy.
    ...

- Finally, apply the changes.

.. code-block:: bash

   $ terraform apply -auto-approve

.. code-block:: bash

    data.archive_file.template_zip: Refreshing state...
    bigip_fast_template.consul-webinar: Creating...
    bigip_fast_template.consul-webinar: Still creating... [10s elapsed]
    bigip_fast_template.consul-webinar: Creation complete after 10s [id=ConsulWebinar]
    bigip_fast_application.nginx-webserver: Creating...
    bigip_fast_application.nginx-webserver: Still creating... [10s elapsed]
    bigip_fast_application.nginx-webserver: Creation complete after 11s [id=Nginx]

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

    Outputs:

    app_url = http://52.44.244.96:8080


**Note:** Please make note of the above app_url link you will need later