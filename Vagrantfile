# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require 'getoptlong'

opts = GetoptLong.new(
    [ '--custom-option', GetoptLong::OPTIONAL_ARGUMENT ]
)
Vagrant.configure(2) do |config|
  #This speeds up subsequent provisions by creating an apt-cache on the host
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  config.vm.define "web" do |web|
    config.vm.provider :virtualbox do |v|
      v.memory = 2048
      v.cpus = 4
    end
    web.vm.box = 'ubuntu/trusty64'

    web.vm.provision :puppet do |puppet|
      puppet.module_path = 'modules'
      puppet.manifests_path = 'manifests'
      puppet.manifest_file = 'default.pp'
    end

    web.vm.provision 'shell', inline: <<-SHELL
       #Install InSpec
       apt-get -y install ruby2.0 ruby2.0-dev gcc make
       update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 10
       update-alternatives --install /usr/bin/gem gem /usr/bin/gem2.0 10
       gem install rake
       gem install serverspec
       cd /vagrant/test
       rake spec
    SHELL
  end


end
