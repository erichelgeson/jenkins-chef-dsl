# If set, install a ruby manager.
if node['jenkins-chef']['ruby-manager']
  include_recipe "jenkins-chef-dsl::_ruby-#{node['jenkins-chef']['ruby-manager']}"
end
