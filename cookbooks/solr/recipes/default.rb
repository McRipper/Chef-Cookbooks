#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright 2010, Jiva Technology Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "jetty"

remote_file node.solr.download do
  source   node.solr.link
  mode     0644
  action   :create_if_missing
end

bash 'unpack solr' do
  code   "tar xzf #{node.solr.download} -C #{node.solr.directory}"
  not_if "test -d #{node.solr.extracted}"
end

bash 'install solr into jetty' do
  code   "mkdir -p #{node.solr.home} && cp #{node.solr.war} #{node.solr.home}/solr.war"
  not_if "test -f #{node.solr.home}/solr.war"
  notifies :restart, resources(:service => "jetty")
end

directory node.solr.data do
  owner     node.jetty.user
  group     node.jetty.group
  recursive true
  mode      "750"
end

template "#{node.jetty.context_dir}/solr.xml" do
  owner  node.jetty.user
  source "solr.context.erb"
  notifies :restart, resources(:service => "jetty")
end