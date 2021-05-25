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
                script {
                  echo "Start of Stage Deploy..."
                  echo "Deploying..."
                  sh '''#!/bin/bash
			    	ssh root@192.168.33.11 >> ENDSSH
			    	docker ps



                 ENDSSH
                 '''
                }
                echo "End of Stage Build..."
            }
        }
        stage('6-Test') {
            steps {
                echo "Start of Stage Test..."
                echo "Testing..."

                echo "End of Stage Build..."
            }
        }
    }
}
