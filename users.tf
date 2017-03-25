// Users
# This Terraform config file is not ideal but is a concession to several other
# ideas that did not work due to limitations in HCL.  If any of the following
# were possible this would be less bad:
#   * Mixed type variables.  ex. a list of arrays
#   * Count support for modules.
#   * Nested map support.  Well, you can make them but lookup() breaks.
#
# To add a new user, add them to aws_iam_user_list first.  Then add them to
# keybase_id_map which will allow creating new IAM keys.  Add them to
# ec2_ssh_id_map so they can have an SSH key available for EC2 hosts.
#

// Variables
variable "aws_iam_user_list" {
  type = "list"
  description = "map of users an their attributes"
  default = []
}

variable "keybase_id_map" {
  type = "map"
  description = "map of users to keybase IDs"
  default = {}
}

variable "ec2_ssh_id_map" {
  type = "map"
  description = "map of users to SSH public keys"
  default = {}
}


// Resources
module "aws_iam_users" {
  #source            = "github.com/tmclaugh/tf_straycat_aws_iam_users"
  source            = "../tf_straycat_aws_iam_users"
  aws_iam_user_list = "${var.aws_iam_user_list}"
  ec2_ssh_id_map    = "${var.ec2_ssh_id_map}"
  keybase_id_map    = "${var.keybase_id_map}"
}


// Outputs
output "aws_iam_users_arn" {
  value = "${module.aws_iam_users.aws_iam_user_arn}"
}


output "aws_iam_access_key_id" {
  value = "${module.aws_iam_users.aws_iam_access_key_id}"
}

output "aws_iam_access_key_encrypted_secret" {
  value = "${module.aws_iam_users.aws_iam_access_key_encrypted_secret}"
}

output "aws_iam_user_login_profile_encrypted_password" {
  value = "${module.aws_iam_users.aws_iam_user_login_profile_encrypted_password}"
}


output "aws_key_pair_fingerprint" {
  value = "${module.aws_iam_users.aws_key_pair_fingerprint}"
}

