name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[apt]",
  "recipe[zsh]",
  "recipe[sudo]",
  "recipe[ntp]",
  "recipe[build-essential]",
  "recipe[vim]",
  "recipe[git]",
  "recipe[screen]",
  "recipe[hostname]",
#  "recipe[monit]", # problemi ad avviare il servizio senza sudo
#  "recipe[iptables]",
  "recipe[fail2ban]"
)

override_attributes(
  :authorization => {
    :sudo => {
      :users => ["deploy", "vagrant"],
      :passwordless => true
    }
  },
  :set_fqdn => "vagrant.staging",
  :monit => { 
    :notify_email => "",
    :mail_format => { 
      :from => "",
      :subject => ""
    }
  }
)

