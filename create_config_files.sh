#!/bin/bash
source .env

envsubst < job_config.xml.example > job_config.xml
envsubst < Vagrantfile.example > Vagrantfile
envsubst < ./groovy_scripts/init_script.groovy.example > ./groovy_scripts/init_script.groovy
envsubst < credential.xml.example > credential.xml
