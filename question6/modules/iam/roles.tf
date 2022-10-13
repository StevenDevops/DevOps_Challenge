resource "aws_iam_role" "iam_role" {
  name                  = format("%s-role", var.env)
  path                  = "/"
  description           = format("This is %s-role", var.env)
  force_detach_policies = false
  tags                  = local.tag

  assume_role_policy = templatefile("${path.module}/files/assume-role-trusted-polices.tpl", {
    account_id = data.aws_caller_identity.current.account_id,
    users      = var.users
  })
}