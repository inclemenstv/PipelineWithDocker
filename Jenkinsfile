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
                   docker build . -t inclemenstv/web_apps:latest
                '''
                echo "Building......."
                echo "End of Stage Build..."
            }
        }
         stage('3-Push docker image') {
            steps {
                echo "Start push image..."
                sh '''
                   docker push inclemenstv/web_apps:latest
                '''
            }
        }
        stage('4-Remove unused docker images') {
            steps {
                echo "Start remove image..."
                sh '''
                   docker rmi inclemenstv/web_apps:latest
                '''
            }
        }
        stage('5-Deploy') {
            steps {
            echo "Start of Stage Deploy..."
            echo "Deploying..."
                script {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_inclemenstv', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                sh """ssh -tt root@192.168.33.11 << EOF
                docker login -u $USERNAME -p $PASSWORD
                docker stop web_app
                docker rm web_app
                docker rmi inclemenstv/web_apps:latest
                docker run -d -p 8080:80 --name web_app inclemenstv/web_apps:latest
                exit
                EOF"""
                }
                }
            echo "End of Stage Build..."
            }
        }
        stage('6-Test') {
            steps {
                echo "Start of Stage Test..."
                echo "Testing..."
                sh '''
                curl -k http://192.168.33.11:8080
                '''
                echo "End of Stage Build..."
            }
        }
    }
}
