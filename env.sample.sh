# Configure with your tenant data 
export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TF_VAR_user_ocid=ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TF_VAR_fingerprint=$(cat ~/.oci/oci_api_key_fingerprint)
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem
export TF_VAR_ssh_public_key=$(cat ~/data/devops/ssh-devops.key.pub)
export TF_VAR_ssh_private_key=$(cat ~/data/devops/ssh-devops.key)
export TF_VAR_region=eu-frankfurt-1

