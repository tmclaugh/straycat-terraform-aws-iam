// Variables
variable "root_admin_name" {
  type = "string"
  description = "The root-admin group has access to everything in the environment. Use with care."
  default = "root-admin"
}
variable "root_admin_members" {
  type = "list"
  description = "List of group members."
}


// Data
data "template_file" "AWSFullAccess" {
  template = "${file("${path.module}/policy_AWSFullAccess.tpl")}"
}


//Resources
module "aws_iam_group_root_admin" {
  source = "../tf_straycat_aws_iam_group"
  aws_iam_group_name = "${var.root_admin_name}"
  aws_iam_group_policy = {
    AWSFullAccess = "${data.template_file.AWSFullAccess.rendered}"
  }
  # FIXME: There's no way for us to have this module depend on another module.
  # We need to handle group membership on our own for that reason.
  #aws_iam_group_members = "${var.root_admin_members}"
  #depends_on = ["module.aws_iam_users"]
}

# FIXME: Once I can do depends_on with modules this becomes unnecessary.
resource "aws_iam_group_membership" "members" {
  name = "${var.root_admin_name}-membership"
  group = "${var.root_admin_name}"
  users = "${var.root_admin_members}"
  depends_on = ["module.aws_iam_group_root_admin", "module.aws_iam_users"]
}


// Outputs
output "aws_iam_group_arn_root_admin" {
  value = "${module.aws_iam_group_root_admin.aws_iam_group_arn}"
}

output "aws_iam_group_name_root_admin" {
  value = "${module.aws_iam_group_root_admin.aws_iam_group_name}"
}

output "aws_iam_group_membership_users_root_admin" {
  value = ["${aws_iam_group_membership.members.users}"]
}

output "aws_iam_group_policies_root_admin" {
  value = "${sort(module.aws_iam_group_root_admin.aws_iam_group_policy)}"
}
