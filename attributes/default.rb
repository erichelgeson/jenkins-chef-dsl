# Suffix of the recipe that implements your auth.
# Eg: github, ldap, etc
default['jenkins-chef']['auth']                  = nil #eg: 'github', 'basic'
default['jenkins-chef']['AuthorizationStrategy'] = nil #eg: 'FullControlOnceLoggedInAuthorizationStrategy'

#  Github auth example:
#  Create a 'Developer Application' on Github.
#  https://github.com/settings/applications
#  Works for Github Enteprise too!
default['jenkins-chef']['github']['site']         = 'https://github.com'
default['jenkins-chef']['github']['api_endpoint'] = 'https://api.github.com'
default['jenkins-chef']['github']['API_KEY']      = 'CHANGEME'
default['jenkins-chef']['github']['API_SECRET']   = 'CHANGEME'

# SCM details
default['jenkins-chef']['git']['name']  = 'jenkins'
default['jenkins-chef']['git']['email'] = 'jenkins@example.com'

# Ruby manager
default['jenkins-chef']['ruby-manager'] = 'rvm' #eg: rvm. TODO: Rbenv

# Jenkins URL
default['jenkins-chef']['webgui']['url'] = 'CHANGEME'

# Jenkins Slave User
default['jenkins-chef']['slave']['user'] = 'jenkins'
default['jenkins']['slave']['dir'] = '/var/lib/jenkins/'

# Jenkins Master User
# This is the user groovy commands will be executed by.
default['jenkins']['master']['user'] = 'CHANGEME'
default['jenkins']['master']['password'] = 'CHANGEME'
