pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('build') {
            steps {
                echo 'building...'
                sh 'docker build -t kdev1234/flask-market:0.0.${BUILD_NUMBER}.RELEASE .'
            }
        }
        stage('run image') {
            steps {
                echo 'running...'
                // sh 'docker run -d -p 5000:5000 kdev1234/flask-market:0.0.${BUILD_NUMBER}.RELEASE'
            }
        }
    }
}