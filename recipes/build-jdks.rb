directory '/opt/jdks'

java_ark 'oracle-jdk6-x86_64' do
  url node['java']['jdk']['6']['x86_64']['url']
  checksum node['java']['jdk']['6']['x86_64']['checksum']
  app_home '/opt/jdks/oracle-jdk6-x86_64'
  action :install
end

java_ark "oracle-jdk7-x86_64" do
  url node['java']['jdk']['7']['x86_64']['url']
  checksum node['java']['jdk']['7']['x86_64']['checksum']
  app_home '/opt/jdks/oracle-jdk7-x86_64'
end

java_ark "oracle-jdk8-x86_64" do
  url node['java']['jdk']['8']['x86_64']['url']
  checksum node['java']['jdk']['8']['x86_64']['checksum']
  app_home '/opt/jdks/oracle-jdk8-x86_64'
  action :install
end

# TODO: Automatically add these jdk's to Jenkins configuration.
