# dynamo.tf

# Create dynamodb table to utilize the lock function in managed terraform remote state
resource "aws_dynamodb_table" "terraform-lock" {
  name           = "${terraform.workspace}_bb_terraform_state"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "${terraform.workspace}_dynamodb_table"
  }

}
