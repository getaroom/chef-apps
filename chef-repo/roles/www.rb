name "www"
description "WWW Runtime Server"

run_list(
  "recipe[users::sysadmins]",
  "recipe[apps]",
)
