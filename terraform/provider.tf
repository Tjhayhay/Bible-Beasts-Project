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
