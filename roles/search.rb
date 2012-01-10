name "search"
description "Add Solr, Java Lucene based search engine."
run_list(
  "recipe[java]",
  "recipe[jetty]",
  "recipe[solr]"
)