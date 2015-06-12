directory '/opt/jdks'

group 'jenkins'
user 'jenkins' do
  gid 'jenkins'
end

#java_ark 'oracle-jdk6-x86_64' do
#  url node['java']['jdk']['6']['x86_64']['url']
#  checksum node['java']['jdk']['6']['x86_64']['checksum']
#  app_home '/opt/jdks/oracle-jdk6-x86_64'
#  owner 'jenkins'
#  group 'jenkins'
#  action :install
#end

java_ark "oracle-jdk7-x86_64" do
  url node['java']['jdk']['7']['x86_64']['url']
  checksum node['java']['jdk']['7']['x86_64']['checksum']
  app_home '/opt/jdks/oracle-jdk7-x86_64'
  owner 'jenkins'
  group 'jenkins'
end

java_ark "oracle-jdk8-x86_64" do
  url node['java']['jdk']['8']['x86_64']['url']
  checksum node['java']['jdk']['8']['x86_64']['checksum']
  app_home '/opt/jdks/oracle-jdk8-x86_64'
  action :install
  owner 'jenkins'
  group 'jenkins'
end

# TODO: Automatically add these jdk's to Jenkins configuration.
