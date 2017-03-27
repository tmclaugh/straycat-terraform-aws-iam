// Outputs

# aws_iam_account_password_policy exports nothing worthwhile.

output "aws_key_pair_admin_key" {
  value = "${map(aws_key_pair.admin_key.key_name, aws_key_pair.admin_key.fingerprint)}"
}

