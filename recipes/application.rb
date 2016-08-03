#
# Cookbook Name::sansapp
# Recipe:: application
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'golang'

application '/home/vagrant/app' do
  # git 'git@github.com:rtacconi/sans_code.git'
  git 'https://github.com/rtacconi/sans_code.git'
end

execute 'force_owner_in_app' do
  command 'chown -R vagrant:vagrant /home/vagrant/app'
end

template '/home/vagrant/app/server.sh' do
  source 'server.sh.erb'
  owner 'vagrant'
  mode '700'
  owner 'vagrant'
end

template '/etc/systemd/system/app.service' do
  source 'systemd_app_config.erb'
  owner 'root'
  mode '644'
  owner 'root'
end

service 'app' do
  action :start
  supports start: true, stop: true, restart: true, status: true
end
