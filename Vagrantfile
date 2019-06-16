IMAGE_NAME = "generic/ubuntu1804"
N = 3

Vagrant.configure("2") do |config|
	config.ssh.insert_key = false
	ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
	config.vm.provision 'shell', inline: 'mkdir -p /root/.ssh'
	config.vm.provision "shell", inline: "echo #{ssh_pub_key} >> /root/.ssh/authorized_keys"

	config.vm.provider "virtualbox" do |v|
		v.memory = 2048
		v.cpus = 2
	end

	(1..N).each do |i|
		config.vm.define "node-#{i}" do |node|
			node.vm.box = IMAGE_NAME
			node.vm.hostname = "node-#{i}"
			node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
		end
	end
end
