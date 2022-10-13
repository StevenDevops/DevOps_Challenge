resource "aws_iam_group" "group" {
  name = format("%s-group", var.env)
  path = "/users/"
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.assume_policy.arn
}