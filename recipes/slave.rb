#
# Cookbook Name:: jenkins-chef-dsl
# Recipe:: slave
#
# Configures Jenkins slave

# TODO: Create the local jenkins user programmatically if it does not exist.


# Include a ruby recipe to make sure ruby is installed - user's choice.
%w(libgmp-dev openjdk-7-jre-headless).each do |pkg|
  package pkg do
    action :install
  end
end

remote_file 'slave.jar' do
  path "#{node['jenkins']['slave']['dir']}slave.jar"
  source node['jenkins']['webgui']['url'] + '/jnlpJars/slave.jar'
  checksum '087800bbef94842c736e9e83254caf8c457b9fbd'
  owner node['jenkins']['slave']['user']
  mode 0771
end

template "#{node['jenkins']['slave']['dir']}slave.sh" do
  source 'slave.sh.erb'
  owner node['jenkins']['slave']['user']
  mode 0775
end

# TODO: Creates an upstart/service that runs the jenkins slave jar in the background
#template '/etc/init.d/jenkins-slave' do
#  source 'jenkins-slave.erb'
#  mode 0755
#end

#service 'jenkins-slave' do
#  supports :start => true, :restart => true
#  action [ :enable, :start ]
#end
