Vagrant.configure("2") do |config|
  #config.vm.box = "ubuntu/trusty64" # Vanilla from Ubuntu
  config.vm.box = "boxcutter/ubuntu1404" # Works with ALL virt options that make sense, Trusty64
  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.provider "virtualbox" do |v|
    # These are set pretty high as rbenv builds ruby from sources, dial in according to your patience levels
    v.memory = 2048
    v.cpus = 4
    v.gui = true
  end

  config.vm.provider "vmware_workstation" do |v|
    # These are set pretty high as rbenv builds ruby from sources, dial in according to your patience levels
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "4"
    v.gui = true
  end
end

Vagrant::Config.run do |config|
  $script = <<-SCRIPT
    set -o verbose
    set -e
    whoami

    sudo apt-get -y update
    
    sudo apt-get -y remove ruby1.9.1  #comes installed on this vagrant box. remove

    sudo apt-get -y install build-essential git curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"'               >> ~/.bashrc
    source ~/.bashrc

    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

    # The following need to be done in simulated interactive mode otherwise the
    # the rbenv specified ruby doesn't entirely work and vagrant install fails
    sudo -H -u vagrant bash -i -c 'rbenv install 2.3.1' #TODO: 2.4.0 when available
    sudo -H -u vagrant bash -i -c 'rbenv rehash'
    sudo -H -u vagrant bash -i -c 'rbenv global 2.3.1'
    sudo -H -u vagrant bash -i -c 'gem install bundler --no-ri --no-rdoc'
    sudo -H -u vagrant bash -i -c 'gem install execjs --no-ri --no-rdoc'
    sudo -H -u vagrant bash -i -c 'gem install therubyracer --no-ri --no-rdoc'
    sudo -H -u vagrant bash -i -c 'gem install github-pages --no-ri --no-rdoc'
    sudo -H -u vagrant bash -i -c 'gem install jekyll-paginate --no-ri --no-rdoc'
    sudo -H -u vagrant bash -i -c 'rbenv rehash'
    sudo -H -u vagrant bash -i -c 'cd /vagrant && bundle install'
    
    sudo -H -u vagrant bash -i -c 'bundle exec jekyll --version'
    
    # Well this last step doesn't work "Inappropriate ioctl for device".
    # anyone know how to fix that?
    # Run it directly by doing doing 'vagrant ssh' then
    # 'cd /vagrant && bundle exec jekyll serve --host 0.0.0.0'
    sudo -H -u vagrant bash -i -c 'bundle exec jekyll serve --watch --drafts --force_polling -H 0.0.0.0'
    

    # end of bash script
  SCRIPT
  config.vm.provision "shell", inline: $script, privileged: false

  config.ssh.forward_agent = true
end