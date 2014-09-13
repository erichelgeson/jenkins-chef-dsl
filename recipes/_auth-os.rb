# Need to add user to jenkins and os

jenkins_script 'setup authentication' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    def instance = Jenkins.getInstance()

    import hudson.security.*
    def realm = new PAMSecurityRealm('#{node['jenkins-chef']['os']['servicename']}')
    instance.setSecurityRealm(realm)

    def strategy = new #{node['jenkins-chef']['AuthorizationStrategy']}()
    instance.setAuthorizationStrategy(strategy)

    instance.save()
  EOH
end

