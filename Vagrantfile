# vim:ft=ruby

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, :path => 'provision.sh'

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id,
                 "--memory", 4096,
                 "--cpus", 2,
                 "--natdnshostresolver1", "on",
                 "--natdnsproxy1", "on"]
  end

  config.vm.define :cmhost1 do |cfg|
       cfg.vm.hostname = "cmhost1"
       cfg.vm.network :private_network, ip: "33.33.33.61", type: "static"
  end

  config.vm.define :cmhost2 do |cfg|
       cfg.vm.hostname = "cmhost2"
       cfg.vm.network :private_network, ip: "33.33.33.62", type: "static"
  end

  config.vm.define :cmhost3 do |cfg|
       cfg.vm.hostname = "cmhost3"
       cfg.vm.network :private_network, ip: "33.33.33.63", type: "static"
  end
end
