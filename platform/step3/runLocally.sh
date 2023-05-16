export GOOGLE_APPLICATION_CREDENTIALS=~/.gcpCreds

export TF_VAR_environment="test"

terraform init
#terraform apply --auto-approve
terraform destroy

rm -rf .terraform*