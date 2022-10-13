{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
            %{ for user in users ~}
            "arn:aws:iam::${account_id}:user/${user}",
            %{ endfor ~}
            "arn:aws:iam::${account_id}:root"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}