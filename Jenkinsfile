pipeline {
    agent any
    triggers{ pollSCM('* * * * *') }
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    environment {
    DOCKERHUB = credentials("${env.DockerHub_ID}")
    }
    stages {
        stage('1-Docker login') {
            steps {
                echo "Docker login..."
                sh '''
                   docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW
                '''
            }
        }
        stage('2-Create docker image') {
            steps {
                echo "Start Build image..."
                sh '''
                   docker build . -t $DOCKERHUB_USR/web_apps:latest
                '''
                echo "Building......."
                echo "End of Stage Build..."
            }
        }
         stage('3-Push docker image') {
            steps {
                echo "Start push image..."
                sh '''
                   docker push $DOCKERHUB_USR/web_apps:latest
                '''
            }
        }
        stage('4-Remove unused docker images') {
            steps {
                echo "Start remove image..."
                sh '''
                   docker image prune -f
                '''
            }
        }
        stage('5-Deploy') {
            steps {
                echo "Start of Stage Deploy..."
                echo "Deploying..."
                script {
                sh """ssh -tt root@$DEPLOY_HOST << EOF
                docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW
                docker stop web_app
                docker rm web_app
                docker rmi $DOCKERHUB_USR/web_apps:latest
                docker run -d -p 8080:80 --name web_app --restart unless-stopped $DOCKERHUB_USR/web_apps:latest
                exit
                EOF"""
                }
                echo "End of Stage Deploy..."
            }
        }
        stage('6-Test') {
            steps {
                echo "Start of Stage Test..."
                echo "Testing..."
                sh '''

                export result=curl -L -s -o /dev/null -I -w "%{http_code}" http://$DEPLOY_HOST:8080 | grep 200
                if [ "$result" == '200']
                then
                    echo "Test Passed"
                else
                    echo "Test Failed"
                fi
                '''
                echo "End of Stage Test..."
            }
        }
    }
}
