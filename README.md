# oci-terraform-formsmkt
Install Oracle Forms with terraform on OCI

## Description
The directory contains terraform scripts to install forms on OCI.

It will:
- Install Forms from the Marketplace
- Create the needed autoconfig file to bootstrap the machine
  - The sample autoinit files in file/.autoconfig.xx. configure Forms to run with a local database
- Bootstrap the machine such that the Forms and local database and installed and started automatically

## Usage
Create a ssh certificate to connect to the machine
```
cd $HOME/.ssh
ssh-keygen -f ssh-devops.key
```

Modify the file env.sample.sh with your OCI Tenant settings.
(See here: [https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm|https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm] )

Start Terraform

```
. ./env.sh
terraform init
terraform apply 
```


