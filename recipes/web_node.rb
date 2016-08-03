#
# Cookbook Name:: sansapp
# Recipe:: web_node
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'nginx'

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template '/etc/nginx/sites-available/default' do
  source 'default.erb'
  variables({
    backends: node['backends']
  })
  notifies :restart, 'service[nginx]', :immediately
end
