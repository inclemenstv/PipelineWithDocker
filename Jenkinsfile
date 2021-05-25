pipeline {
    agent any
    environment {
      PROJECT_NAME = "Task2-Jenkins"
      OWNER_NAME   = "Kostiantyn Pishchanskyi"
    }

    stages {
        stage('1-Build') {
            steps {
                echo "Start of Stage Build..."
                sh '''
                   docker build .
                '''
                echo "Building......."
                echo "End of Stage Build..."
            }
        }
        stage('2-Deploy') {
            steps {
                echo "Start of Stage Deploy..."
                echo "Deploying......."

                echo "End of Stage Build..."
            }
        }
        stage('3-Test') {
            steps {
                echo "Start of Stage Test..."
                echo "Testing......."

                echo "End of Stage Build..."
            }
        }
    }
}