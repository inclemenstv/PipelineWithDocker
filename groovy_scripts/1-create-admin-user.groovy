/*
 * Create an admin user.
 */
import jenkins.model.*
import hudson.security.*

println "--> creating admin user"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "admin")
Jenkins.instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
Jenkins.instance.setAuthorizationStrategy(strategy)

Jenkins.instance.save()