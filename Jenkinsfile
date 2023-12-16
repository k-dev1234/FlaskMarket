pipeline {
    agent any
    environment {
        DOCKER_USER     = credentials('docker_username')
        sship     = credentials('SSH_IP')
        sshuser = credentials('SSH_USERNAME')
    }
    stages {
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
        stages {
            stage('ssh login') {
                steps {
                    sshagent(credentials: ['ssh-key']) {
                        sh '''ssh -o StrictHostKeyChecking=no -l ${sshuser} ${sship} bash -c \'"
                            if [ -d  \''~/FlaskMarket'\' ]; then sudo rm -rf ~/FlaskMarket/; fi
                            git clone -b kolla-build --single-branch https://github.com/k-dev1234/FlaskMarket.git
                            cd ~/FlaskMarket/
                            helm upgrade --install flask-helm-release flask-helm/ --values flask-helm/values.yaml
                        "\''''
                    }
                }
            }
        }
    }
}
