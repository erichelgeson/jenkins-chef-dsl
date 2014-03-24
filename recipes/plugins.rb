#
# Cookbook Name:: jenkins-chef-dsl
# Recipe:: plugins
#
# Installs Jenkins plugins

# Flag set to true if plugin is installed or updated and jenkins will be restarted.
#  Pattern from https://tickets.opscode.com/browse/CHEF-2452
restart_required = false

### Plugins Start ###
# git-essentails
%w(git credentials ssh-credentials git-client scm-api github github-api github-oauth mailer).each do |plugin|
  jenkins_plugin plugin do
    notifies :create, "ruby_block[jenkins_restart_flag]", :immediately
  end
end

# build-pipeline-plugin
%w(javadoc maven-plugin jquery dashboard-view parameterized-trigger token-macro run-condition conditional-buildstep build-pipeline-plugin).each do |plugin|
  jenkins_plugin plugin do
    notifies :create, "ruby_block[jenkins_restart_flag]", :immediately
  end
end

# folders
%w(matrix-auth credentials cloudbees-folder).each do |plugin|
  jenkins_plugin plugin do
    notifies :create, "ruby_block[jenkins_restart_flag]", :immediately
  end
end

# others
%w(job-dsl promoted-builds greenballs pegdown-formatter ruby-runtime rvm).each do |plugin|
  jenkins_plugin plugin do
    notifies :create, "ruby_block[jenkins_restart_flag]", :immediately
  end
end
### Plugins End ###

# Is notified when a 'jenkins_plugin' is installed or updated.
ruby_block "jenkins_restart_flag" do
  block do
    restart_required = true
  end
  action :nothing
end

service "jenkins" do
  action :restart
  only_if { restart_required }
end
