name "web"
description "Install web stack with Rbenv, Passenger and Nginx."
run_list(
  "recipe[ruby_build]",
  "recipe[rbenv::system]",
  "recipe[passenger]",
  "recipe[logrotate]",
  "recipe[imagemagick::minimagick]"
)