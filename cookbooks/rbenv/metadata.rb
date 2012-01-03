maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Manages rbenv and its installed rubies. Several LWRPs are also defined."
long_description "Please refer to README.md (it's long)."
version          "0.6.1"

recommends "ruby_build"   # if using the rbenv_ruby LWRP, ruby-build must be installed
recommends "java"         # if using jruby, java is required on system

supports "ubuntu"
