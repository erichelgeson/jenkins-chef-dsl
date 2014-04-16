# Full disclosure, i dont use rbenv and couldnt get it to work, here's my WIP.
# If someone can make it work, great!

# Rbenv
#default['jenkins-chef']['rbenv']['version'] = '2.1.1'
#include_recipe 'rbenv::default'
#include_recipe 'rbenv::ruby_build'
#include_recipe 'rbenv::rbenv_vars'

#rbenv_ruby node['jenkins-chef']['rbenv']['version'] do
#  action :install
#end

#rbenv_gem 'bundler' do
#  ruby_version node['jenkins-chef']['rbenv']['version']
#end
