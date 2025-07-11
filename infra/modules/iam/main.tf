resource "aws_iam_role" "this" {
  name = var.role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_instance_profile" "this" {
  name = var.profile_name
  role = aws_iam_role.this.name
}

resource "aws_iam_role_policy" "this" {
  name = var.policy_name
  role = aws_iam_role.this.id
  policy = var.policy
}
