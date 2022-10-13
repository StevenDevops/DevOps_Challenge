locals {
  # We defined all users account here
  envs = {
    test = {
      users = [ "test-user-1", "test-user-2" ]
    }
    prod = {
      users = [ "prod-user-1", "prod-user-2" ]
    }
  }
}