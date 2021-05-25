pipeline {
    agent any
    triggers{ pollSCM('* * * * *') }
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
        timestamps()
    }
    environment {
      PROJECT_NAME = "Task2-Jenkins"
      OWNER_NAME   = "Kostiantyn Pishchanskyi"
    }

    stages {
        stage('1-Docker login') {
            steps {
                echo "Docker login..."
                withCredentials([usernamePassword(credentialsId: 'dockerhub_inclemenstv', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh '''
                   docker login -u $USERNAME -p $PASSWORD
                '''
                }
            }
        }
        stage('2-Create docker image') {
            steps {
                echo "Start Build image..."
                sh '''
                   docker build . -t inclemenstv/web_apps:$BUILD_ID
                '''
                echo "Building......."
                echo "End of Stage Build..."
            }
        }
         stage('3-Push docker image') {
            steps {
                echo "Start push image..."
                sh '''
                   docker push inclemenstv/web_apps:$BUILD_ID
                '''
            }
        }
        stage('4-Deploy') {
            steps {
                echo "Start of Stage Deploy..."
                echo "Deploying......."

                echo "End of Stage Build..."
            }
        }
        stage('5-Test') {
            steps {
                echo "Start of Stage Test..."
                echo "Testing......."

                echo "End of Stage Build..."
            }
        }
    }
}
