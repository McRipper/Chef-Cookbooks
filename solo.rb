# chef-solo -c /etc/chef/solo.rb -j /etc/chef/dna.json
file_cache_path "/tmp/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
log_level :info
log_location STDOUT
ssl_verify_mode :verify_none