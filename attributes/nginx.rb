case node['platform_family']
when 'rhel', 'fedora'
  case node['platform']
  when 'centos'
    # See http://wiki.nginx.org/Install
    default['nginx']['upstream_repository'] = "http://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch/"
  when 'amazon'
    default['nginx']['upstream_repository'] = 'http://nginx.org/packages/rhel/6/$basearch/'
  else
    default['nginx']['upstream_repository'] = "http://nginx.org/packages/rhel/#{node['platform_version'].to_i}/$basearch/"
  end
when 'debian'
  default['nginx']['upstream_repository'] = "http://nginx.org/packages/#{node['platform']}"
end
