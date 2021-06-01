/*
 * Create an admin user.
 */
import jenkins.model.*
import hudson.security.*
import jenkins.model.Jenkins
import jenkins.model.JenkinsLocationConfiguration

def instance = Jenkins.getInstance()
def env = System.getenv()

def user = env['ADMIN_USERNAME']
def pass = env['ADMIN_PASSWORD']
def JENKINS_HOST = env['JENKINS_HOST']
def JENKINS_EMAIL = env['JENKINS_EMAIL']

println "--> creating admin user "

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "admin")
Jenkins.instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
Jenkins.instance.setAuthorizationStrategy(strategy)
Jenkins.instance.save()

// get Jenkins location configuration
def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()

// set Jenkins URL
jenkinsLocationConfiguration.setUrl("http://127.0.0.1:8080/")

// set Jenkins admin email address
jenkinsLocationConfiguration.setAdminAddress("test@gmail.com")

// save current Jenkins state to disk
jenkinsLocationConfiguration.save()