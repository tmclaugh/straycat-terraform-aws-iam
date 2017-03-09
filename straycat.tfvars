// Account variables
terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"
    config {
      encrypt = "true"
      bucket  = "straycat-dhs-org-straycat-terraform"
      key     = "aws_iam.tfstate"
      region  = "us-east-1"
    }
  }
}

aws_account = "straycat"
aws_profile = "straycat"
aws_region = "us-east-1"
