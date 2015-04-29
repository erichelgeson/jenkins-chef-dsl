#
# Cookbook Name:: jenkins-chef-dsl
# Recipe:: default
#

include_recipe 'chef-sugar::default'

# The jenkins cookbook comes with a very simple java installer. If you need more
#  complex java installs you are on your own.
#  https://github.com/opscode-cookbooks/jenkins#java
include_recipe 'jenkins::java'

# There is a bug in the latest Jenkins that breaks the api/ssh key auth.
# Also you can not pin packages using apt/yum with Jenkins repo
# So we opt for the war install and pin to 1.555
# * https://issues.jenkins-ci.org/browse/JENKINS-22346
# * https://github.com/opscode-cookbooks/jenkins/issues/170
node.set['jenkins']['master']['install_method'] = 'war'
node.set['jenkins']['master']['version']  = '1.596.2'
node.set['jenkins']['master']['source']   = "#{node['jenkins']['master']['mirror']}/war-stable/#{node['jenkins']['master']['version']}/jenkins.war"
node.set['jenkins']['master']['checksum'] = '769fee082d420819f0113d5271be98004d3f3227d98c4e445f6e5f60dde6de37'

include_recipe 'jenkins::master'

# Install any required plugins.
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
