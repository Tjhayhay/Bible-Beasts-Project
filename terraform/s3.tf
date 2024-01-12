# s3.tf

# S3 for Terraform State
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "bb-terraform-state-backend-${terraform.workspace}"

  object_lock_enabled = true

  tags = {
    Name = "${terraform.workspace}-terraform-state-bucket"
  }

}

resource "aws_s3_bucket_versioning" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
