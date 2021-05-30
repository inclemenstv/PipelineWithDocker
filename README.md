# PipelineWithDocker

### Purpose

1. Creating a test environment (Vagrantfile have 2 VM with Jenkins and VM for deploy)
2. Jenkins is automatically installed, as well as configuration and pipeline are created


### Preparation

1. pre-install Vagrant (https://www.vagrantup.com/docs/installation)
2. Create jenkins.yml and .env files and copy the contents of jenkins.yml.example and .env.example into them
3. Set your values to variables in the .env file and change jenkins.yml

### How to use

1. Clone this repo. 
2. Use command vagrant up to create both VM
3. Login to Jenkins by default ip 127.0.0.1:8080 use your credentials

