# The most common configuration options are documented and commented below.
# For a complete reference, please see the online documentation at
# https://docs.vagrantup.com.
class Homestead

  # Configure The Box
  def Homestead.configure( config, settings )

    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://atlas.hashicorp.com/search.
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "homestead"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: settings["ip"] ||= "192.168.10.10"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # View the documentation for the provider you are using for more
    # information on available options.
    config.vm.provider "virtualbox" do |vb|
      # Configure A Few VirtualBox Settings
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    config.vm.network "forwarded_port", guest: 80, host: 8000
    config.vm.network "forwarded_port", guest: 3306, host: 33060
    config.vm.network "forwarded_port", guest: 5432, host: 54320

    # Configure The Public Key For SSH Access
    config.vm.provision "shell" do |s|
      s.inline = "echo $1 | tee -a /home/vagrant/.ssh/authorized_keys"
      s.args = [File.read(File.expand_path(settings["authorize"]))]
    end

    # Copy The SSH Private Keys To The Box
    settings["keys"].each do |key|
      config.vm.provision "shell" do |s|
        s.privileged = false
        s.inline = "echo \"$1\" > /home/vagrant/.ssh/$2 && chmod 600 /home/vagrant/.ssh/$2"
        s.args = [File.read(File.expand_path(key)), key.split('/').last]
      end
    end

    # Copy The Bash Aliases
    # config.vm.provision "shell" do |s|
    #   s.inline = "cp /vagrant/aliases /home/vagrant/.bash_aliases"
    # end

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    settings["folders"].each do |folder|
      # Register All Of The Configured Shared Folders
      config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil
    end

    # Enable provisioning with a shell script. Additional provisioners such as
    # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
    # documentation for more information about their specific syntax and use.

    # Run provisioning script with asible
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/ansible/playbook.yml"
      ansible.sudo = true

      # add extra vars to be used in the ansible playbook
      ansible.extra_vars = {
        projects:[],
        vhosts:[],
        # list of extra packages
        packages: settings["packages"] ||= []
      }

      settings["folders"].each do |folder|
        ansible.extra_vars[:projects].push({
          path: folder["to"],
          name: folder["to"].split('/')[-1]
        })
      end

      settings["sites"].each_with_index do |sites, i|
        name = ansible.extra_vars[:projects][i][:name]
        path = ansible.extra_vars[:projects][i][:path]
        virtualenv = "/.virtualenvs/#{name}/lib/python2.7/site-packages"

        ansible.extra_vars[:vhosts].push({
          root_path: path,
          wsgi_path: sites['to'],
          virtualenv_path: path.split('/')[0..-2].join('/') + virtualenv,
          servername: sites['map'],
          filename: sites['map'].sub(/\./, '_')
        })
      end
    end

  end
end
