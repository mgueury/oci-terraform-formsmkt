# oci-terraform-formsmkt
Install Oracle Forms with Terraform on OCI

## Description
The directory contains Terraform scripts to install forms on OCI.

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

```
# Configure with your tenant data 
export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TF_VAR_user_ocid=ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TF_VAR_fingerprint=$(cat ~/.oci/oci_api_key_fingerprint)
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem
export TF_VAR_ssh_public_key=$(cat ~/data/devops/ssh-devops.key.pub)
export TF_VAR_ssh_private_key=$(cat ~/data/devops/ssh-devops.key)
export TF_VAR_region=eu-frankfurt-1
```

Start Terraform

```
. ./env.sh
terraform init
terraform apply 
```


