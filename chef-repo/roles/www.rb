name "www"
description "WWW Runtime Server"

run_list(
  "recipe[users::sysadmins]",
  "recipe[apps]",
)

default_attributes({
  "apps" => {
    "user_search_qualifier" => "groups:sysadmin"
  },
})
