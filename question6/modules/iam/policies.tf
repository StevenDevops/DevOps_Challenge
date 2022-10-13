data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      aws_iam_role.iam_role.arn
    ]
  }
}

resource "aws_iam_policy" "assume_policy" {
  name   = format("%s-policy", var.env)
  policy = data.aws_iam_policy_document.assume_role_policy_document.json
}
