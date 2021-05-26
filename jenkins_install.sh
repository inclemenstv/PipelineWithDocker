#!/bin/bash

echo "Updating apt-get"
sudo apt-get -qq update > /dev/null 2>&1

echo "Installing java"
sudo apt-get -y install openjdk-11-jdk > /dev/null 2>&1

echo "Installing git"
sudo apt-get -y install git > /dev/null 2>&1

echo "Installing jenkins"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update > /dev/null 2>&1
sudo apt-get -y install jenkins > /dev/null 2>&1


echo "Skipping the initial setup"
echo 'JAVA_ARGS="-Djenkins.install.runSetupWizard=false"' >> /etc/default/jenkins

echo "Setting up users"
sudo rm -rf /var/lib/jenkins/init.groovy.d
sudo mkdir /var/lib/jenkins/init.groovy.d
sudo cp /vagrant/2-globalMatrixAuthorizationStrategy.groovy /var/lib/jenkins/init.groovy.d/
sudo cp /vagrant/1-create-admin-user.groovy /var/lib/jenkins/init.groovy.d/
#sudo cp /vagrant/test.groovy /var/lib/jenkins/init.groovy.d/
#sudo cp /vagrant/3-create-seed-jobs.groovy /var/lib/jenkins/init.groovy.d/
sudo cp /vagrant/jenkins-set-url-and-email.groovy /var/lib/jenkins/init.groovy.d/


sudo service jenkins start
sleep 1m

echo "Installing jenkins plugins"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
rm -f jenkins_cli.jar.*
wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
while IFS= read -r line
do
  list=$list' '$line
done < /vagrant/jenkins-plugins.txt
java -jar ./jenkins-cli.jar -auth admin:$JENKINSPWD -s http://localhost:8080 install-plugin $list

echo "Restarting Jenkins"
sudo service jenkins restart

sleep 1m
