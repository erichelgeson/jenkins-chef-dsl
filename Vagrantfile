Vagrant.configure("2") do |c|
# Plugin-specific configurations
  # Detects vagrant-omnibus plugin
  if Vagrant.has_plugin?('vagrant-omnibus')
    puts 'INFO: Vagrant-omnibus plugin detected.'
    c.omnibus.chef_version = :latest
  else
    puts "FATAL: Vagrant-omnibus plugin not detected. Please install the plugin with\n 'vagrant plugin install vagrant-omnibus' from any other directory\n before continuing."
    exit
  end

  # Detects vagrant-berkshelf plugin and requests it being removed.
  # This plugin is depricated.
  if Vagrant.has_plugin?('berkshelf')
    puts "FATAL: Vagrant-berkshelf plugin was detected. Please uninstall the plugin with\n 'vagrant plugin uninstall vagrant-berkshelf' from any other directory\n before continuing."
    exit
  end

  c.vm.box = "opscode-ubuntu-12.04"
  c.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"
  c.vm.hostname = "jenkins-chef-dsl"
  c.vm.network(:forwarded_port, {:guest=>8080, :host=>9090, :auto_correct=>true})

  c.vm.provider :virtualbox do |p|
    p.customize ["modifyvm", :id, "--cpus", "2"]
    p.customize ["modifyvm", :id, "--memory", "1024"]
  end

  c.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"

    chef.add_recipe "apt::default"
    chef.add_recipe "jenkins::java"
    chef.add_recipe "jenkins-chef-dsl"
  end
end
