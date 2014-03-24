#
# Cookbook Name:: jenkins-chef-dsl
# Recipe:: auth
#
# Configures Authentication.

# This is just for having this example work, get the keys from a secure location.
# These keys are for the 'chef' jenkins user to interact with the Jenkins API.
private_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAxGxFIfLTWZR6d1yM52tdfDkiTS0XUU/9PHy1be+IW6H+OgSw
WEB+jG6sO7t5aWqCk3aY2yNj9izDf5lYpWjbSSfTzCcBj4bimoLIbN4OBgyML/90
ns2dlPsR95XMvj2DpPr+5rtex88QLYrJ82sDHYgtPF2kEj5EbgIdJTLYJsbL1aeb
pg23pRC0c6xMktRqj4/IYX8nDZ/PSJJmXJ0UD6Brcd/BxZfc4GwYJP/GYa3qeEve
+k8yEHhw3vJoe9zFzB0N9an1fZoMVb9ahj0rvzu0ssfoKZo3hhUe54vQcvl5/ApR
SFLxpAF/Q33AknI9qzdSez9k+KpdK181NsN/3wIDAQABAoIBAD8dEvGflq2X+enU
gSny460AprbpoC5uZ05CPAHBD61x1cBKtWcGAiOZhBoFWTO4F5DOcLspGfuF0qNz
YHp1wNA2zeUxO10k2DcRgtkIWLU03u6lRJGqO9IdAl7tcUZHeb9PLwxwdDn7nJUl
nVJrtiqNEQvugsOh4lb+suK6/Z0nfotq+5hcHB2GUH1UGBJVmgUzDi4UAg/kq1uZ
a8OnGY+E4MDntm8NulHbe4FEcPYlXq6v2rmV7zZhsU6s3JhN1mH/xC98DVrZ6UgM
3fTq2VetUWBRjQeyzRUIL52628S/PY3XcUuUvtLIU1isKu9+LdDzms7XpgpbfDhf
8aFeb/ECgYEA+Bt4DKFwOtx1CxcF4eh97stDsxhGlcYWIJjZQaSUtl/GYaOFzL/n
IynH1z3Bfud9PR8qaLGmrdlI48bczltgwvL1FYF1IuIcBWcWNJ5OyYviESkf+x2T
w/QYgJB7mX5qNGLrOcj2PFgXsydeFOYKiC0uLjwTWWZvPfU/vFLSLzsCgYEAyqvl
Hy668zI/DNWBwj0NH9nTfobUcQphNYDP+1kZ4aean+XVNjj3VyBDXuv195lt6d1R
fSvjFCZAmVHHavGmmb3fzg9NGhpxjW/KHhRd9NrjdgCcs26xUcB1mJph6kY949G2
PKL1AUIytnuV6dLbIozfyWesXNooLKidWD7Nb60CgYAp6YIDKDZsSxeekvoUapDz
iPTbyUsLPBY61XdGBoZ0tIMvtU8CAp0KLKGss6r/RB28+InSe8g7cAxHJi3g0kDr
Td2nD2J5TRcMtphitSd8FpxO59KWOi3fGVoWRdILYPaR+O/hqBgoo30Fb64N+7pl
vLQjbVSbcplyLv7gUmFdRwKBgFtvZ8REseVMUvO4U31NS+GFxYv8ylVhaG/Z+Hse
PLX4hqMC7skytCwjiyGE9QhKuTLcPYpqRV1u0JAbPAu8j/wmlJUDhDZ1natAtwAR
Ej6IjjxLlGbDVs5aNPOvGuO14vAoSb5biouR0Q1Q/lZqYaDZy5Cy7ClL5voW7D3G
v6pVAoGBALcf/smvGOAwo6aVQBb3YyL97FexKmocEl6OcRr26zSENV27mXCSAGPt
iRYDwimEUcbHmhpVFcuxcvcrh0c+blcFGlGhzz64oWOUfDuIg5iA6nZwnwItr/29
bZmPGN4tuQWWjqbk/vWwS9noMSVPccHkerJ01TuCineYjJmSSw5x
-----END RSA PRIVATE KEY-----"

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEbEUh8tNZlHp3XIzna118OSJNLRdRT/08fLVt74hbof46BLBYQH6Mbqw7u3lpaoKTdpjbI2P2LMN/mVilaNtJJ9PMJwGPhuKagshs3g4GDIwv/3SezZ2U+xH3lcy+PYOk+v7mu17HzxAtisnzawMdiC08XaQSPkRuAh0lMtgmxsvVp5umDbelELRzrEyS1GqPj8hhfycNn89IkmZcnRQPoGtx38HFl9zgbBgk/8Zhrep4S976TzIQeHDe8mh73MXMHQ31qfV9mgxVv1qGPSu/O7Syx+gpmjeGFR7ni9By+Xn8ClFIUvGkAX9DfcCScj2rN1J7P2T4ql0rXzU2w3/f"

# Creates the 'chef' Jenkins user and assciates the public key
# Needs anonymous auth to create a user, to then use this users there after.
# See Caviots in opscode/jenkins
jenkins_user 'chef' do
  full_name   'Chef Client'
  public_keys [public_key]
end

# Set the private key on the Jenkins executor, must be done only after the user
# has been created, otherwise API will require authentication and not be able to create the user.
ruby_block 'set private key' do
  block { node.set['jenkins']['executor']['private_key'] = private_key }
end

# This adds Github oAuth security. (login with your github id.)
# TODO: More examples?
jenkins_script 'add_gh_authentication' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    import hudson.security.*
    import org.jenkinsci.plugins.*

    def instance = Jenkins.getInstance()

    def githubRealm = new GithubSecurityRealm(
      'https://github.com',
      'https://api.github.com',
      '#{node['jenkins-chef']['github']['API_KEY']}',
      '#{node['jenkins-chef']['github']['API_SECRET']}'
    )
    instance.setSecurityRealm(githubRealm)

    def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
    instance.setAuthorizationStrategy(strategy)

    instance.save()
  EOH
end
