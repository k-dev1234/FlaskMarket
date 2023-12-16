pipeline {
    agent any
    environment {
        DOCKER_USER     = credentials('docker_username')
    }
    stages {
        stage('Checkout') {
            steps {
                sshagent(credentials: ['ssh-key']) {
                    sh 'ssh 192.168.2.243'
                }
            }
        }
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('clean previous build') {
            steps {
                sh 'docker stop flask-app-run || true && docker rm flask-app-run || true'
                sh 'echo "y" | docker system prune -a'
            }
        }
        stage('build') {
            steps {
                echo 'building...'
                sh 'docker build -t ${DOCKER_USER}/flask-market:0.0.${BUILD_NUMBER} .'
                sh 'docker build -t ${DOCKER_USER}/flask-market:latest .'
            }
        }
        stage('push image to hub') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
                withDockerRegistry(credentialsId: 'docker-token', url: 'https://index.docker.io/v1/') {
                    echo 'running...'
                    sh 'docker push ${DOCKER_USER}/flask-market:0.0.${BUILD_NUMBER}'
                    sh 'docker push ${DOCKER_USER}/flask-market:latest'
                }
            }
        }
        // stage('run helm kubernetes') {
        //     steps {
        //         withKubeConfig([credentialsId: 'credentialsId', serverUrl: 'https://192.168.49.2:8443']) {
        //             echo 'helm me!!!!'
        //             sh 'helm upgrade --install --set imageName=${BUILD_NUMBER} flask-helm-release flask-helm/ --values flask-helm/values.yaml'
        //         }
        //     }
        // }
    }
}
