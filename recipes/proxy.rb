# Set up a reverse proxy to allow jenkins to run on port 80

require 'chef/sugar'

# Using Apache httpd for rhel based distros, nginx for others, just testing now.
if rhel?
  package "httpd"
  service 'httpd' do
    action :start
  end

  template "/etc/httpd/conf/httpd.conf" do
    source "httpd.conf"
  end
else
  package "nginx"

  template '/etc/nginx/sites-available/jenkins' do
    source 'nginx-jenkins'
    notifies :reload, "service[nginx]"
  end

  service 'nginx' do
    action :start
  end

  file '/etc/nginx/sites-enabled/default' do
    action :delete
  end

  bash 'enable jenkins nginx site' do
    code <<-EOC
      ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/jenkins
    EOC
    notifies :reload, "service[nginx]"
    not_if {File.exists?("/etc/nginx/sites-enabled/jenkins")}
  end
end
