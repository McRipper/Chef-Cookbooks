name "database"
description "Database role"
run_list(
  "recipe[mysql::server]"
)