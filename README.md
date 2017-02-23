# Introduction

django_env, a Vagrant development environment for django.

django_env is a Django development environment provisioned on Vagrant using Ansible. Used for supporting new and existing django project(s) on one Vagrant VM.

## What does it all mean? ###
This project allows one to setup a [django](https://www.djangoproject.com/) project(s) and configure the project(s) quickly and easily all within one Vagrant box. We're using [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org) as a means to decouple the project from the host operating system. This allows the django project(s) to stay consistent and independent of the host, your machine, operating system.
We're using [Ansible](http://www.ansible.com/about) for [provisioning](https://docs.vagrantup.com/v2/provisioning/index.html), installing software and altering configurations, of the development environment. That's to say, you can destroy the development environment and rebuild it for scratch with just two commands(More on that later).

## How do I get set up?

This section explains how to get started and setup your django project(s) with Vagrant and Ansible.

1. Download and install the prerequisite software.
    * Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and the Virtualbox [extension pack](https://www.virtualbox.org/wiki/Downloads).
    * Download and install [Vagrant](https://www.vagrantup.com/downloads.html).
    * Download and add Vagrant base box `vagrant box add ubuntu/trusty64`.
    * Download and install [Ansilbe](http://docs.ansible.com/intro_installation.html). I recommend using pip and easy_install, directions can be found [here.](http://docs.ansible.com/intro_installation.html#latest-releases-via-pip)

1. Clone django_env repo.

    Simply clone the django_env repository into a central directory where you keep all of your django projects, as the Vagrant box will serve as the host to all of your django projects:

    ```bash
    git clone https://github.com/moviedo/django_env.git
    ```

1. Configure your project.

    You can find detailed information on how to configure you're project within the *Homestead.yml* file in the section titled **Vagrant VM Config**.

1. Start the VM

    Run the command `vagrant up` to start the VM. This may take a few minutes and you should see the the progression of the provisioning script.

1. SSH into the VM.

    You can ssh into your development VM by running the command `vagrant ssh`.

1. Run the builtin django server and check your site.

    Make sure you use the `0.0.0.0` IP address in order to server the site to your host machine.

    ```bash
    python manage.py server 0.0.0.0:80
    ```

## Vagrant VM Config

This section explains all the configuration options available in the Homestead.yml file regarding Vagrant settings.

`ip: "192.168.10.10"`

IP address for creating a private network for your Vagrant VM. You can find more information about it [here](https://docs.vagrantup.com/v2/networking/index.html) The default configuration works find for most cases.

`memory: 2048`

This is the amount of RAM your Vagrant VM will consume. Unless your computer has large amounts of RAM the default is recommended.

`cpus: 1`

This is the number of CPUs the Vagrant VM will consume. Unless you're using a multi-cpu computer the default is *strongly* recommended.

`cpus: 1`

This is the number of CPUs the Vagrant VM will consume. Unless you're using a multi-cpu computer the default is *strongly* recommended.


`forward_port: 8000`

The port to access django web pages on you host machine.

`mysql_port: 33060`

The port to access MySQL on you host machine.

`psql_port: 54320`

The port to access Postgres on you host machine.

### Configure Your Shared Folders
The folders property of the Homestead.yml file lists all the folders you wish to share with the Vagrant environment. As files within these folders are changed, they will be kept in sync between your local machine and the Homestead environment. You may configure as many shared folders as necessary!

The first parameter, *map*, is the path to the directory your project is located, and the second parameter, *to*, is the path to the directory in the Vagrant environment. The Vagrant synced directory will be created during provisioning.

```yml
# paths to your synced project directories
folders:
  - map: ~/Developer/project_directory_name
    to: /home/vagrant/project_directory_name
```

### Extra Packages
The packages property take a yaml list of packages that will be installed using the aptitude package manager. This is used for python modules that have C/C++ dependencies, such as PostGIS.


```yml
# list of packages used for projects
packages:
  - vim
  # etc
```

### Configuring New Projects

If you haven't yet created your django project using the command `django-admin.py startproject mysite`, then fear not. Create the directory name for the project you wish to start and add that empty directory to the yaml configurations. The provisioning process will create a new django project for you.

## Included Software

* Ubuntu 16.04
* Python 2.7
* MySQL
* Postgres 9.6
* SqLite
* SpatiaLite
* Node 9.6.5 & npm 3.10
* Grunt, Gulp, Bower, Brunch, Yarn
* git
* vim
* pip
* virtualenv
* virtualenvwrapper

## Ports

The following ports are forwarded from your Vagrant environment by default:

* SSH: 2222 → Forwards To 22
* HTTP: 8000 → Forwards To 8000
* MySQL: 33060 → Forwards To 3306
* Postgres: 54320 → Forwards To 5432

## Connecting To Your Databases

The Asnbile playbook has preconfigured the the Postgres and MySQL databases with the `username: vagrant` and `password: secret`.

To connect to your MySQL or Postgres database from your main machine via Navicat or Sequel Pro, you should connect to 127.0.0.1 and port 33060 (MySQL) or 54320 (Postgres). The username and password for both databases is homestead / secret.

## Adding to your tech stack

A side note on adding more to the technology stack for your project. If you need Amazon Elastic search, PostGIS or some other infrastructure for your project you should add to the Ansible provisioning script(located in the provisioning/ansible). Also, feel free to update the Homestead.rb script with the Vagrant provisioner of your choosing.

## Contribution guidelines

* TBD (Writing tests, Code review, Other guidelines)

## Who do I talk to?

* TBD (Repo owner or admin, Other community or team contact)
