#!/bin/bash
source /vagrant/.env

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
echo 'JAVA_ARGS="-Djenkins.install.runSetupWizard=false -Dcasc.jenkins.config=/home/vagrant/jenkins.yml"' >> /etc/default/jenkins



echo "Setting up users"
sudo rm -rf /var/lib/jenkins/init.groovy.d
sudo mkdir /var/lib/jenkins/init.groovy.d
sudo cp /vagrant/groovy_scripts/2-globalMatrixAuthorizationStrategy.groovy /var/lib/jenkins/init.groovy.d/
sudo cp /vagrant/groovy_scripts/1-create-admin-user.groovy /var/lib/jenkins/init.groovy.d/
sudo cp /vagrant/groovy_scripts/jenkins-set-url-and-email.groovy /var/lib/jenkins/init.groovy.d/
sudo cp /vagrant/jenkins.yml /home/vagrant


sudo service jenkins start
sleep 1m

echo "Installing jenkins plugins"
rm -f jenkins_cli.jar.*
wget -q $JENKINS_HOST/jnlpJars/jenkins-cli.jar
while IFS= read -r line
do
  list=$list' '$line
done < /vagrant/jenkins-plugins.txt
java -jar jenkins-cli.jar -s $JENKINS_HOST -auth $ADMIN_USERNAME:$ADMIN_PASSWORD install-plugin $list

echo "upload pipeline config"
java -jar jenkins-cli.jar -s $JENKINS_HOST -auth admin:admin check-configuration < jenkins.yml

echo "Restarting Jenkins"
sudo service jenkins restart

sleep 1m

