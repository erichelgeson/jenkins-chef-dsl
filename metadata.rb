name             'jenkins-chef-dsl'
maintainer       'Eric Helgeson'
maintainer_email 'erichelgeson@gmail.com'
license          'Apache 2'
description      'Installs/Configures jenkins-chef-dsl'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.2'

depends 'jenkins', '~> 2.0'
depends 'chef-sugar', '~> 1.2'
depends 'apt'
depends 'artifactory'
depends 'java', '~> 1.0'
depends 'selinux_policy', '~> 0.4'

supports 'ubuntu'
supports 'centos'
