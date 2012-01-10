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

## TOFIX

* Monit
* Solr
* Passenger Nginx template