name "database"
description "Database role"
run_list(
  "recipe[mysql::server]"
)

override_attributes(
  :mysql => { 
    :server_root_password => "adminpass"
  }
)