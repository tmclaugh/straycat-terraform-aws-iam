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

