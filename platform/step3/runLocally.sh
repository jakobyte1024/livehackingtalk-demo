export GOOGLE_APPLICATION_CREDENTIALS=~/.gcpCreds

export TF_VAR_environment="test"

terraform init \
    -backend-config="prefix=$TF_VAR_environment/step3-terraform/state"
#terraform apply --auto-approve
#terraform destroy

rm -rf .terraform*