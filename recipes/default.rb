#
# Cookbook Name:: jenkins-chef-dsl
# Recipe:: default
#

include_recipe 'chef-sugar::default'

# The jenkins cookbook comes with a very simple java installer. If you need more
#  complex java installs you are on your own.
#  https://github.com/opscode-cookbooks/jenkins#java
include_recipe 'jenkins::java'
include_recipe 'jenkins::master'

# Install any required plugins and setup auth.
include_recipe 'jenkins-chef-dsl::plugins'
include_recipe 'jenkins-chef-dsl::auth'

# Setup .gitconfig, needed on first chef
template "#{node['jenkins']['master']['home']}/.gitconfig" do
  source 'gitconfig.erb'
  user node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
end

# Using Chef you will likey need these utilities to test.
include_recipe 'jenkins-chef-dsl::chefdk'

# Initial jenkinds-dsl-bootstrap job
#  This job will be the only job created "by hand" and will create all other jobs.
#  In this example, we just have the jobs staticly defined in a xml file with a
#  DSL Groovy script. In practice you would specify a Git repo and build poll/webhook that.
# Currently 'jenkins_job' takes a file on the file system. In the future it may
#  take a template, etc.
cookbook_file "#{Chef::Config[:file_cache_path]}/jenkins-job-DSL-bootstrap.xml" do
  source 'jenkins-job-DSL-bootstrap.xml'
end

xml = File.join(Chef::Config[:file_cache_path], 'jenkins-job-DSL-bootstrap.xml')
jenkins_job 'jenkins-job-DSL-bootstrap' do
  config xml
end

template '/etc/sudoers.d/jenkins-sudoers' do
  source 'jenkins-sudoers.erb'
end
