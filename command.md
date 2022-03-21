# Usefull commands

# Install
cp env.sample.sh ../env.sh
ssh-keygen -f ssh-test.key

. ../env2.sh
terraform apply --auto-approve
terraform destroy --auto-approve
ssh -i ../ssh-devops.key opc@xxxx


