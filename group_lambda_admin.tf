// Variables
variable "lambda_admin_name" {
  type = "string"
  description = "The lambda-admin group has wide ranging access to work with Lambda and related services."
  default = "lambda-admin"
}
variable "lambda_admin_members" {
  type = "list"
  description = "List of group members."
  default = []
}

variable "lambda_aws_managed_policies" {
  type = "list"
  description = "List of lambda policies"
  default = ["arn:aws:iam::aws:policy/AWSLambdaFullAccess", "arn:aws:iam::aws:policy/AmazonApiGatewayAdministrator"]
}


//Resources
module "aws_iam_group_lambda_admin" {
  source = "../tf_straycat_aws_iam_group"
  aws_iam_group_name = "${var.lambda_admin_name}"
  aws_iam_group_aws_managed_policy_arns = ["${var.lambda_aws_managed_policies}"]
}

# FIXME: Once I can do depends_on with modules this becomes unnecessary.
resource "aws_iam_group_membership" "lambda" {
  name = "${var.lambda_admin_name}-membership"
  group = "${var.lambda_admin_name}"
  users = "${var.lambda_admin_members}"
  depends_on = ["module.aws_iam_group_lambda_admin", "module.aws_iam_users"]
}


// Outputs
output "aws_iam_group_arn_lambda_admin" {
  value = "${module.aws_iam_group_lambda_admin.aws_iam_group_arn}"
}

output "aws_iam_group_name_lambda_admin" {
  value = "${module.aws_iam_group_lambda_admin.aws_iam_group_name}"
}

output "aws_iam_group_membership_users_lambda_admin" {
  value = ["${aws_iam_group_membership.lambda.users}"]
}

output "aws_iam_group_inline_policies_lambda_admin" {
  value = "${sort(module.aws_iam_group_lambda_admin.aws_iam_group_inline_policy)}"
}

output "aws_iam_group_managed_policies_lambda_admin" {
  value = "${sort(module.aws_iam_group_lambda_admin.aws_iam_group_managed_policy)}"
}

