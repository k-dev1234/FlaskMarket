pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('clean previous build') {
            steps {
                sh 'docker container stop --no-run-if-empty flask-app-run'
                sh 'docker rm -f --no-run-if-empty flask-app-run'
                sh 'y | docker system prune -a'
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
                sh 'docker run -d --name flask-app-run -p 5000:5000 kdev1234/flask-market:0.0.${BUILD_NUMBER}.RELEASE'
            }
        }
    }
}