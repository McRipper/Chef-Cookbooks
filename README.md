# Chef

Chef recipes to install a base system with rbenv, Passenger and Nginx
Search engine provided by Solr


## Capistrano

To let capistrano install the correct gems you must add this to your delpoy.rb

``` ruby
require "bundler/capistrano"

set :default_environment, {
  'PATH' => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
```

## Vagrant

This is a sample Vagrantfile used to test this cookbooks

``` ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  
  config.vm.box = "lucid32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  
  config.vm.customize do |vm|
    vm.memory_size = 324
    vm.cpu_execution_cap = 80
  end
  
  config.vm.boot_mode = :gui
  
  config.vm.network "33.33.33.10"
  
  config.vm.forward_port "http", 80, 8080
  config.vm.forward_port "solr", 8983, 8983
  
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "config/chef/cookbooks"
    chef.roles_path = "config/chef/roles"
    chef.log_level = :debug
    
    chef.add_role "base"
    chef.add_role "app"
    chef.add_role "database"
    chef.add_role "search"
    chef.add_role "web"
    
    # chef.json.merge!(JSON.parse(File.read("config/chef/dna.json")))
  end
end
```

## VERSION

### v1.0

Base system config

## TOFIX

* Solr (Almost done!)
* Add more monit template
* Add Git host key verification
* Add default staging ssh-keys
* Add deploy user to www-data group




Solr home must be inside your app configuration
