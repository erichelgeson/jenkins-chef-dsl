# in the future, maybe use this instead of installing Gems.

remote_file "#{Chef::Config[:file_cache_path]}/chefdk_0.0.1-1_amd64.deb" do
  source "http://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.0.1-1_amd64.deb"
end

dpkg_package "#{Chef::Config[:file_cache_path]}/chefdk_0.0.1-1_amd64.deb" do
  action :install
end
