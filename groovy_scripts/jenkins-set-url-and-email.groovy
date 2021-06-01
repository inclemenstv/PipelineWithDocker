#!groovy

// imports
import jenkins.model.Jenkins
import jenkins.model.JenkinsLocationConfiguration


def env = System.getenv()
def JENKINS_HOST = env['JENKINS_HOST']
def JENKINS_EMAIL = env['JENKINS_EMAIL']


// get Jenkins location configuration
def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()

// set Jenkins URL
jenkinsLocationConfiguration.setUrl("${JENKINS_HOST}")

// set Jenkins admin email address
jenkinsLocationConfiguration.setAdminAddress("${JENKINS_EMAIL}")

// save current Jenkins state to disk
jenkinsLocationConfiguration.save()

