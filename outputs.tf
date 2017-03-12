// Outputs

# aws_iam_account_password_policy exports nothing worthwhile.

output "aws_key_pair_key_name_admin_key" {
  value = "${aws_key_pair.admin_key.key_name}"
}

output "aws_key_pair_fingerprint_admin_key" {
  value = "${aws_key_pair.admin_key.fingerprint}"
}

