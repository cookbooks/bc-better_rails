#
# Cookbook Name:: rails
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rails_user = (node['rails']['user'] || node['rails']['app_name'] || 'root')

log "Woot #{node.inspect}"

directory node['rails']['root'] do
  owner rails_user
  group "betterplace"
  mode "0755"
  action :create
  recursive true
end

directory ::File.join(node['rails']['root'], 'config') do
  owner rails_user
  group "betterplace"
  mode "0755"
  action :create
end