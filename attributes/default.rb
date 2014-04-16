# Suffix of the recipe that implements your auth.
# Eg: github, ldap, etc
default['jenkins-chef']['auth']                  = nil #eg: 'github', 'basic'
default['jenkins-chef']['AuthorizationStrategy'] = nil #eg: 'FullControlOnceLoggedInAuthorizationStrategy'

# Github auth example:
#  Create a 'Developer Application' on Github.
#  https://github.com/settings/applications
#  Works for Github Enteprise too!
default['jenkins-chef']['github']['site']         = "https://github.com"
default['jenkins-chef']['github']['api_endpoint'] = "https://api.github.com"
default['jenkins-chef']['github']['API_KEY']      = "CHANGEME"
default['jenkins-chef']['github']['API_SECRET']   = "CHANGEME"
