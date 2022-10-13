module "iam" {
  source   = "./modules/iam"
  for_each = local.envs
  env      = each.key
  users    = each.value.users
}