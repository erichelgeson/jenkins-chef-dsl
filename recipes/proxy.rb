# Set up a reverse proxy to allow jenkins to run on port 80

case node['platform_family']
when 'rhel', 'fedora'

  yum_repository 'nginx' do
    description 'Nginx.org Repository'
    baseurl         node['nginx']['upstream_repository']
    gpgkey      'http://nginx.org/keys/nginx_signing.key'
    action :create
  end

when 'debian'
  include_recipe 'apt::default'

  apt_repository 'nginx' do
    uri          node['nginx']['upstream_repository']
    distribution node['lsb']['codename']
    components   %w(nginx)
    deb_src      true
    key          'http://nginx.org/keys/nginx_signing.key'
  end
end

package 'nginx'

directory '/etc/nginx/conf.d/' do
  owner 'root'
  group 'jenkins'
  mode '0775'
end

template '/etc/nginx/conf.d/jenkins.conf' do
  source 'nginx-jenkins'
  notifies :reload, "service[nginx]"
end

file '/etc/nginx/conf.d/default.conf' do
  action :delete
  notifies :reload, "service[nginx]"
end

service 'nginx' do
  action :start
end

cookbook_file '/root/nginx-reload.sh' do
  source 'nginx-reload.sh'
  owner 'root'
  group 'root'
  mode '0755'
end

selinux_policy_boolean 'httpd_can_network_connect' do
  value true
  notifies :start, 'service[nginx]', :immediate
end
