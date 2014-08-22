name             'jenkins-chef-dsl'
maintainer       'Eric Helgeson'
maintainer_email 'erichelgeson@gmail.com'
license          'All rights reserved'
description      'Installs/Configures jenkins-chef-dsl'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.3'

depends 'jenkins', '~> 2.0'
depends 'chef-sugar', '~> 1.2'
depends 'apt'
depends 'artifactory'
depends 'java', '~> 1.0'

supports 'ubuntu'
supports 'centos'
