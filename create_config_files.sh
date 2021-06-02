#!/bin/bash
source .env

envsubst < job_config.xml.template > job_config.xml
envsubst < Vagrantfile.template > Vagrantfile
envsubst < ./groovy_scripts/init_script.groovy.template > ./groovy_scripts/init_script.groovy
envsubst < credential.xml.template > credential.xml
