# provider.tf

# Specify the provider and access details
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]

  default_tags {
    tags = {
      Environment = "${terraform.workspace}"
      Project     = "Bible-Beasts-Project"
      Source      = "Terraform"
    }
  }
}

# Terraform backend for terraform state management

/*# Backend must remain commented until the Bucket
 and the DynamoDB table are created.
 After the creation you can uncomment it,
 run "terraform init" and then "terraform apply" */

# terraform {
#   backend "s3" {
#     bucket = "bp-terraform-state-backend"
#     workspace_key_prefix    =  "${terraform.workspace}"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     dynamodb_table = "bp_terraform_state"
#   }
# }
