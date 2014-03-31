# Suffix of the recipe that implements your auth.
# Eg: github, ldap, etc
default['jenkins-chef']['auth']                  = 'github'
default['jenkins-chef']['AuthorizationStrategy'] = 'FullControlOnceLoggedInAuthorizationStrategy'

# Github auth
#  Create a 'Developer Application' on Github.
#  https://github.com/settings/applications
#  Works for Github Enteprise too!
default['jenkins-chef']['github']['site']         = "https://github.com"
default['jenkins-chef']['github']['api_endpoint'] = "https://api.github.com"
default['jenkins-chef']['github']['API_KEY']      = "CHANGEME"
default['jenkins-chef']['github']['API_SECRET']   = "CHANGEME"
