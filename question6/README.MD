#Question 6

_Noted: It's not good to share the permission for all user in the same account. E.g test-user can assume the prod-role so I decided to separate the permission for them. Only root account have permission to assume all roles._

#How to run it
Please install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) first.

Please copy your AWS credentials to ~/.aws/credentials (default profile)

E.g

```
[default]
aws_access_key_id = xxxxx
aws_secret_access_key = xxx
```
Choose the region for deployment:
```
export AWS_DEFAULT_REGION=me-south-1
```

Run terraform init:

```
terraform init
```

Run terraform plan:

```
terraform plan
```

Run terraform apply and approve:

```
terraform apply
```

Run terraform destroy to cleanup the resource:

```
terraform destroy
```

### Terraform plan output:
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # module.iam["prod"].data.aws_iam_policy_document.assume_role_policy_document will be read during apply
  # (config refers to values not yet known)
 <= data "aws_iam_policy_document" "assume_role_policy_document"  {
      + id   = (known after apply)
      + json = (known after apply)

      + statement {
          + actions   = [
              + "sts:AssumeRole",
            ]
          + resources = [
              + (known after apply),
            ]
        }
    }

  # module.iam["prod"].aws_iam_group.group will be created
  + resource "aws_iam_group" "group" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "prod-group"
      + path      = "/users/"
      + unique_id = (known after apply)
    }

  # module.iam["prod"].aws_iam_group_policy_attachment.group_policy_attachment will be created
  + resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
      + group      = "prod-group"
      + id         = (known after apply)
      + policy_arn = (known after apply)
    }

  # module.iam["prod"].aws_iam_policy.assume_policy will be created
  + resource "aws_iam_policy" "assume_policy" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "prod-policy"
      + path      = "/"
      + policy    = (known after apply)
      + policy_id = (known after apply)
      + tags_all  = (known after apply)
    }

  # module.iam["prod"].aws_iam_role.iam_role will be created
  + resource "aws_iam_role" "iam_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = [
                              + "arn:aws:iam::854911248207:user/prod-user-1",
                              + "arn:aws:iam::854911248207:user/prod-user-2",
                              + "arn:aws:iam::854911248207:root",
                            ]
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "Provides access to kubernetes operations users."
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "prod-role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags                  = {
          + "Env"       = "prod"
          + "Terraform" = "true"
        }
      + tags_all              = {
          + "Env"       = "prod"
          + "Terraform" = "true"
        }
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.iam["prod"].aws_iam_user.iam_user["prod-user-1"] will be created
  + resource "aws_iam_user" "iam_user" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "prod-user-1"
      + path          = "/"
      + tags          = {
          + "Env"       = "prod"
          + "Terraform" = "true"
        }
      + tags_all      = {
          + "Env"       = "prod"
          + "Terraform" = "true"
        }
      + unique_id     = (known after apply)
    }

  # module.iam["prod"].aws_iam_user.iam_user["prod-user-2"] will be created
  + resource "aws_iam_user" "iam_user" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "prod-user-2"
      + path          = "/"
      + tags          = {
          + "Env"       = "prod"
          + "Terraform" = "true"
        }
      + tags_all      = {
          + "Env"       = "prod"
          + "Terraform" = "true"
        }
      + unique_id     = (known after apply)
    }

  # module.iam["prod"].aws_iam_user_group_membership.user_membership["prod-user-1"] will be created
  + resource "aws_iam_user_group_membership" "user_membership" {
      + groups = [
          + "prod-group",
        ]
      + id     = (known after apply)
      + user   = "prod-user-1"
    }

  # module.iam["prod"].aws_iam_user_group_membership.user_membership["prod-user-2"] will be created
  + resource "aws_iam_user_group_membership" "user_membership" {
      + groups = [
          + "prod-group",
        ]
      + id     = (known after apply)
      + user   = "prod-user-2"
    }

  # module.iam["prod"].aws_iam_user_policy_attachment.user_policy_attachment["prod-user-1"] will be created
  + resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + user       = "prod-user-1"
    }

  # module.iam["prod"].aws_iam_user_policy_attachment.user_policy_attachment["prod-user-2"] will be created
  + resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + user       = "prod-user-2"
    }

  # module.iam["test"].data.aws_iam_policy_document.assume_role_policy_document will be read during apply
  # (config refers to values not yet known)
 <= data "aws_iam_policy_document" "assume_role_policy_document"  {
      + id   = (known after apply)
      + json = (known after apply)

      + statement {
          + actions   = [
              + "sts:AssumeRole",
            ]
          + resources = [
              + (known after apply),
            ]
        }
    }

  # module.iam["test"].aws_iam_group.group will be created
  + resource "aws_iam_group" "group" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "test-group"
      + path      = "/users/"
      + unique_id = (known after apply)
    }

  # module.iam["test"].aws_iam_group_policy_attachment.group_policy_attachment will be created
  + resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
      + group      = "test-group"
      + id         = (known after apply)
      + policy_arn = (known after apply)
    }

  # module.iam["test"].aws_iam_policy.assume_policy will be created
  + resource "aws_iam_policy" "assume_policy" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "test-policy"
      + path      = "/"
      + policy    = (known after apply)
      + policy_id = (known after apply)
      + tags_all  = (known after apply)
    }

  # module.iam["test"].aws_iam_role.iam_role will be created
  + resource "aws_iam_role" "iam_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = [
                              + "arn:aws:iam::854911248207:user/test-user-1",
                              + "arn:aws:iam::854911248207:user/test-user-2",
                              + "arn:aws:iam::854911248207:root",
                            ]
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "Provides access to kubernetes operations users."
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "test-role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags                  = {
          + "Env"       = "test"
          + "Terraform" = "true"
        }
      + tags_all              = {
          + "Env"       = "test"
          + "Terraform" = "true"
        }
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.iam["test"].aws_iam_user.iam_user["test-user-1"] will be created
  + resource "aws_iam_user" "iam_user" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "test-user-1"
      + path          = "/"
      + tags          = {
          + "Env"       = "test"
          + "Terraform" = "true"
        }
      + tags_all      = {
          + "Env"       = "test"
          + "Terraform" = "true"
        }
      + unique_id     = (known after apply)
    }

  # module.iam["test"].aws_iam_user.iam_user["test-user-2"] will be created
  + resource "aws_iam_user" "iam_user" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "test-user-2"
      + path          = "/"
      + tags          = {
          + "Env"       = "test"
          + "Terraform" = "true"
        }
      + tags_all      = {
          + "Env"       = "test"
          + "Terraform" = "true"
        }
      + unique_id     = (known after apply)
    }

  # module.iam["test"].aws_iam_user_group_membership.user_membership["test-user-1"] will be created
  + resource "aws_iam_user_group_membership" "user_membership" {
      + groups = [
          + "test-group",
        ]
      + id     = (known after apply)
      + user   = "test-user-1"
    }

  # module.iam["test"].aws_iam_user_group_membership.user_membership["test-user-2"] will be created
  + resource "aws_iam_user_group_membership" "user_membership" {
      + groups = [
          + "test-group",
        ]
      + id     = (known after apply)
      + user   = "test-user-2"
    }

  # module.iam["test"].aws_iam_user_policy_attachment.user_policy_attachment["test-user-1"] will be created
  + resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + user       = "test-user-1"
    }

  # module.iam["test"].aws_iam_user_policy_attachment.user_policy_attachment["test-user-2"] will be created
  + resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + user       = "test-user-2"
    }

Plan: 20 to add, 0 to change, 0 to destroy.
```