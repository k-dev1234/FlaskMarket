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
                sh 'docker stop flask-app-run || true && docker rm flask-app-run || true'
                sh 'y | docker system prune -a'
            }
        }
        stage('build') {
            steps {
                echo 'building...'
                sh 'docker build -t kdev1234/flask-market:0.0.${BUILD_NUMBER}.RELEASE .'
            }
        }
        // stage('run image') {
        //     steps {
        //         echo 'running...'
        //         sh 'docker run -d --rm --name flask-app-run -p 5000:5000 kdev1234/flask-market:0.0.${BUILD_NUMBER}.RELEASE'
        //     }
        // }
        stage('push image to hub') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
                withDockerRegistry(credentialsId: '2491d34e-57f5-4c65-9756-72d2f81a186d', url: 'https://index.docker.io/v1/') {
                    echo 'running...'
                    sh 'docker push kdev1234/flask-market:0.0.${BUILD_NUMBER}.RELEASE'
                }
            }
        }
        stage('run helm kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'credentialsId', serverUrl: 'https://192.168.49.2:8443']) {
                    echo 'helm me!!!!'
                    sh 'helm upgrade --install --set imageName=${BUILD_NUMBER} flask-helm-release flask-helm/ --values flask-helm/values.yaml'
                }
            }
        }
    }
}
