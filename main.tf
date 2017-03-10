// Primary IAM resources.

resource "aws_iam_account_password_policy" "default" {
  # We assume folks are using a password manager
  allow_users_to_change_password = true
  minimum_password_length = 16
  require_lowercase_characters = true
  require_uppercase_characters = true
  require_numbers = true
  require_symbols = true

  # We require MFA on accounts so we're going to go with the updates NIST
  # guidelines of not forcing rotation unless necessary.  We set
  # password_reuse_prevention in case we need to force a roll.
  #max_password_age = 90
  password_reuse_prevention = 5
}

# This is our master AWS keypair for EC2.  This should only be used by folks
# needing to troubleshoot new host issues.  Otherwise people should be granted
# access to hosts through the keys dropped by config management.
resource "aws_key_pair" "admin_key" {
  key_name = "admin-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCz4bPCi/CQQKm59keW174upnk+w1pckK7GK5xPUF7ZgdGtWgQjQlDhc3JrnLbxUMsY/5grAMppjSKhHd0r/CweNDt94fFSlVEcgOKO3XZDl9hJoWbg/VxBbBQGpDU92IlbsRtE1dA7gciVUWF/nE3UNICxgzvDjP+ngJ6V2PxmraKnAry5RiFTYePAdSwZD6HgUx5jByToEFN7D3Nocw+EXViEKptsgpGLfw/Y9jNpvAlgCg3pTPPdd0Po3hb4H6rokjCSk0mfOJngzXg1+dCgpwiftQ689OtbeFh+hVRtMgVc5cftu2lrzq6BFAKpIq4XCBVV6VCQS9H4lsEpGK2JJJ/GCZEP6f+r110wgUeiseUh9jTnXLf9Dy3nGlh7KO3uyz2SySRlxUr0Vv7j2Q8lNwRJLdncAIMfqvR5CAeIpe+N8oM/RqfLywLhESHxFElENNINJ52gJ8ukTw7QGK5z341mNWZ2SpbBa9T7uwPXNsO20IG8iWIs9TT8+NYXUp3jBmmrmFJrvBjfeP4Eg1If7L2NkiWFzvwNg5TNIv8OWeDH5O/xRBYLBYlYXkfBQOPoNUNReYEp4a/4FPmcmMillw1rpchhi5XKKp42MA6GvjGqn6Sc4ew89xc7Jw0lK1SG0pO1cFKyTXZulMsmXXaT4teLmYZSy0qps2QUi/SwUw== tmclaughlin@tomcat-ts"
}
