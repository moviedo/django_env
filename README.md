# django_env, a Vagrant development environment
> one box to rule them all

django_env is a Django development environment provisioned on Vagrant using Ansible. Used for supporting multiple django project on one Vagrant instance.

## What does it all mean? ###
This project allows one to setup multiple [django](https://www.djangoproject.com/) projects and configure the projects quickly and easily all within one Vagrant box. We're using [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org) as a means to decouple the project from the host operating system. This allows the [django](https://www.djangoproject.com/) projects to stay consistent and independent of the host, your machine, operating system.
We're using [Ansible](http://www.ansible.com/about) for [provisioning](https://docs.vagrantup.com/v2/provisioning/index.html), installing software and altering configurations, of the development environment. That's to say, you can destroy the development environment and rebuild it for scratch with just two commands(More on that later).

## How do I get set up?
### Prerequisite Software
* Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and the Virtualbox [extension pack](https://www.virtualbox.org/wiki/Downloads).
* Download and install [Vagrant](https://www.vagrantup.com/downloads.html).
* Downlaad and add Vagrant base box `vagrant box add ubuntu/trusty64`.
* Download and install [Ansilbe](http://docs.ansible.com/intro_installation.html). I recommend using pip and easy_install, directions can be found [here.](http://docs.ansible.com/intro_installation.html#latest-releases-via-pip)

### Installing django_env
Simply clone the repository django_env repository into a central directory where you keep all of your django projects, as the Vagrant box will serve as the host to all of your django projects:

```batch
git clone https://github.com/moviedo/django_env.git Environment
```

### Set Your SSH Key
Edit the Homestead.yml file. In this file, you can configure the path to your public SSH key, as well as the folders you wish to be shared between your main machine and the Vagrant virtual machine.

Don't have an SSH key? Checkout this [link](https://help.github.com/articles/generating-ssh-keys/) to help you get started.

Once you have created a SSH key, specify the key's path in the authorize property of your Homestead.yml file:

```yml
# path to your public ssh key
authorize: ~/.ssh/id_rsa.pub
```

### Configure Your Shared Folders
The folders property of the Homestead.yml file lists all of the folders you wish to share with the Vagrant environment. As files within these folders are changed, they will be kept in sync between your local machine and the Homestead environment. You may configure as many shared folders as necessary!

The first parameter, map, is the path to the directory your project is located, and the second parameter, to, is the path to the directory in the Vagrant environment. The Vagrant synced directory will be created during provisioning.

```yml
folders:
  - map: ~/Developer/project_directory_name
    to: /home/vagrant/project_directory_name
```

#### Configuring New Projects

If you haven't yet created your django project using the command `django-admin.py startproject mysite`, then fear not. Create the directory name for the project you wish to start and add that empty directory to the folders yml configurations. The provisioning process will create a new django project for you.

## Included Software

* Ubuntu 14.04
* Apache 2.4
* Python 2.7
* MySQL
* Postgres 9.3
* Node (With Bower, Grunt, and Gulp)
* git
* curl
* wget
* RVM (With compass, sass)
* virtualenv
* virtualenvwrapper

## Ports

The following ports are forwarded from your Vagrant environment:

* SSH: 2222 → Forwards To 22
* HTTP: 8000 → Forwards To 80
* MySQL: 33060 → Forwards To 3306
* Postgres: 54320 → Forwards To 5432

## Connecting To Your Databases

The Asnbile playbook has preconfigured the the Postgres and MySQL databases with the username: homestead and password: secret.

To connect to your MySQL or Postgres database from your main machine via Navicat or Sequel Pro, you should connect to 127.0.0.1 and port 33060 (MySQL) or 54320 (Postgres). The username and password for both databases is homestead / secret.

## Adding to your tech stack

A side note on adding more to the technology stack for your project. If you need Amazon Elastic search, PostGIS or some other infrastructure for your project you should add to the Ansible provisioning script(located in the provisioning/ansible). Also, feel free to update the Homestead.rb script with the Vagrant provisioner of your choosing.

## Contribution guidelines

* TBD (Writing tests, Code review, Other guidelines)

## Who do I talk to?

* TBD(Repo owner or admin, Other community or team contact)
