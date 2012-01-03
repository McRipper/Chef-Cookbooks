# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  
  config.vm.box = "lucid32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  
  config.vm.customize do |vm|
    vm.memory_size = 324
    vm.cpu_execution_cap = 80
  end
  
  # Boot with a GUI so you can see the screen. (Default is headless)
  config.vm.boot_mode = :gui
  
  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  config.vm.network "33.33.33.10"
  
  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port "http", 80, 8080
  
  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  
  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "config/chef/cookbooks"
    chef.roles_path = "config/chef/roles"
    chef.log_level = :debug
    
    # chef.add_recipe "mysql::server"
    # chef.add_recipe "git::server"
    chef.add_role "base"
    chef.add_role "app"
    chef.add_role "database"
    chef.add_role "search"
    chef.add_role "web"
    
    # chef.json.merge!(JSON.parse(File.read("config/chef/dna.json")))
  end

end

# sudo dhclient