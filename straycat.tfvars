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

// IAM Users
aws_iam_user_list = [
  "tmclaugh"
]

# The user must exist in aws_iam_user_list or run will fail.
keybase_id_map = {
  tmclaugh = "tmclaugh"
}

# The user must exist in aws_iam_user_list or run will fail.
ec2_ssh_id_map = {
  tmclaugh = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCz4bPCi/CQQKm59keW174upnk+w1pckK7GK5xPUF7ZgdGtWgQjQlDhc3JrnLbxUMsY/5grAMppjSKhHd0r/CweNDt94fFSlVEcgOKO3XZDl9hJoWbg/VxBbBQGpDU92IlbsRtE1dA7gciVUWF/nE3UNICxgzvDjP+ngJ6V2PxmraKnAry5RiFTYePAdSwZD6HgUx5jByToEFN7D3Nocw+EXViEKptsgpGLfw/Y9jNpvAlgCg3pTPPdd0Po3hb4H6rokjCSk0mfOJngzXg1+dCgpwiftQ689OtbeFh+hVRtMgVc5cftu2lrzq6BFAKpIq4XCBVV6VCQS9H4lsEpGK2JJJ/GCZEP6f+r110wgUeiseUh9jTnXLf9Dy3nGlh7KO3uyz2SySRlxUr0Vv7j2Q8lNwRJLdncAIMfqvR5CAeIpe+N8oM/RqfLywLhESHxFElENNINJ52gJ8ukTw7QGK5z341mNWZ2SpbBa9T7uwPXNsO20IG8iWIs9TT8+NYXUp3jBmmrmFJrvBjfeP4Eg1If7L2NkiWFzvwNg5TNIv8OWeDH5O/xRBYLBYlYXkfBQOPoNUNReYEp4a/4FPmcmMillw1rpchhi5XKKp42MA6GvjGqn6Sc4ew89xc7Jw0lK1SG0pO1cFKyTXZulMsmXXaT4teLmYZSy0qps2QUi/SwUw== tmclaughlin@tomcat-ts"
}


// Group membership
root_admin_members = ["tom", "tmclaugh"]

