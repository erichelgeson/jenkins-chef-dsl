# This adds Github oAuth security. (login with your github id.)
# TODO: More examples?
jenkins_script 'add_gh_authentication' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    import hudson.security.*
    import org.jenkinsci.plugins.*

    def instance = Jenkins.getInstance()

    def githubRealm = new GithubSecurityRealm(
      '#{node['jenkins-chef']['github']['site']}',
      '#{node['jenkins-chef']['github']['api_endpoint']}',
      '#{node['jenkins-chef']['github']['API_KEY']}',
      '#{node['jenkins-chef']['github']['API_SECRET']}'
    )
    instance.setSecurityRealm(githubRealm)

    def strategy = new #{node['jenkins-chef']['AuthorizationStrategy']}()
    instance.setAuthorizationStrategy(strategy)

    instance.save()
  EOH
end
