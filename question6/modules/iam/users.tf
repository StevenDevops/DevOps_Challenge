resource "aws_iam_user" "iam_user" {
  for_each = toset(var.users)
  name     = each.value
  tags     = local.tag
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  for_each   = toset(var.users)
  user       = aws_iam_user.iam_user[each.key].name
  policy_arn = aws_iam_policy.assume_policy.arn
}

resource "aws_iam_user_group_membership" "user_membership" {
  for_each = toset(var.users)

  user   = aws_iam_user.iam_user[each.key].name
  groups = [aws_iam_group.group.name]
}
