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

### Configurations
TBD

## Contribution guidelines

* TBD (Writing tests, Code review, Other guidelines)

## Who do I talk to?

* TBD(Repo owner or admin, Other community or team contact)
