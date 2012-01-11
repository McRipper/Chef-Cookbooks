name "search"
description "Add Solr, Java Lucene based search engine."
run_list(
  "recipe[java]",
  "recipe[jetty]",
  "recipe[solr]"
)


override_attributes(
  :jetty => {
    :java_options => "-Dsolr.solr.home=/opt/solr -Xmx256m -Djava.awt.headless=true",
    :user    => "solr",
    :group   => "solr",
    :home    => "/opt/solr",
    :log_dir => "/var/log/solr"
  },
  :solr => {
    :home => "/opt/solr",
    :data => "/opt/solr/data"
  }
)