2.0 Lab Module 2 Exploring The SACA 
====================================

**Lab 2** will focus on the GitHub page were the F5 Azure SACA Terraform
scripts reside. There will no commands entered into GitBash or VS Code.

Go to: https://github.com/f5devcentral/f5-azure-saca

You should see something like this:

|image34|

Take a moment, scroll down and read the information available. Pay
attention to the section where the inputs are documented:

|image35|

Now let’s find and click on the **variables.tf** file:

|image36|

This is where we defined variables for the root module. They are defined
with a **variable** block:

But they are referenced from within an object named **var**:

The variables.tf file has the definitions and default values of the
variables used in the repository. If a variable is not defined via
another method, then the default value specified here will be used.

Other ways if defining variables:

From the command line using -var:

Or in a file (.tfvars or .tfvars.json)

Or automatically with:

-  Files named exactly **terraform.tfvars** or
   **terraform.tfvars.json**.

-  Any files with names ending in **.auto.tfvars** or
   **.auto.tfvars.json.**

In the next lab we will be creating and using an auto.admin.tfvars file.

These types of variable files are useful for predefining multiple
configurations. For example if you had a SACA stack in Azure Commercial
and in Azure for Government you could have **saca.com.tfvars** and
**saca.gov.tfvars** and use the same github repository with a different
command line switch to deploy whichever one you wanted.

|image37| **Stop, this is the end of Module 2.**
