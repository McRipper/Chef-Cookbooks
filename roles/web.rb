name "web"
description "Install web stack with Rbenv, Passenger and Nginx."
run_list(
  "recipe[ruby_build]",
  "recipe[rbenv::system]",
  "recipe[rbenv::user_install]",
  "recipe[passenger]",
  "recipe[logrotate]"
)

override_attributes({
  :rbenv => { 
    :rubies => ["1.9.3-p0"],
    :global => "1.9.3-p0",
    :gems => {
      '1.9.3-p0' => [
        { 'name' => 'bundler', 'version' => '1.1.rc.6', 'rbenv_version' => '1.9.3-p0' },
        { 'name' => 'passenger', 'version' => '3.0.11', 'rbenv_version' => '1.9.3-p0' }
      ]
    },
    :user_installs => { 'user' => 'vagrant' }
  }
})