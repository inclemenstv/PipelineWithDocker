pipeline {
    agent any
<<<<<<< HEAD
    triggers{ cron('* * * * *') }
=======
>>>>>>> a230dd8d994f2af088dcf63d6cd682438deefffc
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactnumToKeepStr: '5'))
        timestamps()
    }
    environment {
      PROJECT_NAME = "Task2-Jenkins"
      OWNER_NAME   = "Kostiantyn Pishchanskyi"
    }

    stages {
        stage('1-Create docker image') {
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
