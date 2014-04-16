# You will probably want to add some users so you can login!

# Turn on basic authentication
jenkins_script 'setup authentication' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    def instance = Jenkins.getInstance()

    import hudson.security.*
    def realm = new HudsonPrivateSecurityRealm(false)
    instance.setSecurityRealm(realm)

    def strategy = new #{node['jenkins-chef']['AuthorizationStrategy']}()
    instance.setAuthorizationStrategy(strategy)

    instance.save()
  EOH
end
