name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[apt]",
  "recipe[iptables]",
  "recipe[openssh]",
  "recipe[zsh]",
  "recipe[sudo]",
  "recipe[ntp]",
  "recipe[build-essential]",
  "recipe[vim]",
  "recipe[git]",
  # "recipe[ssh_known_hosts]",
  "recipe[screen]",
  "recipe[hostname]",
  "recipe[monit]",
  "recipe[fail2ban]"
)

# export LC_ALL=it_IT.UTF-8