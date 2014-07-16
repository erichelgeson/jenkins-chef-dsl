# Set up a reverse proxy to allow jenkins to run on port 80

package "nginx"

template '/etc/nginx/sites-available/jenkins' do
  source 'nginx-jenkins'
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
