pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "jitendramauryadev/myfirstprojectongithub"
        DOCKER_TAG = "latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat '''
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    '''
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                bat 'docker push %DOCKER_IMAGE%:%DOCKER_TAG%'
            }
        }

        stage('Pull & Run Container') {
            steps {
                bat '''
                docker rm -f html-app || exit 0
                docker pull %DOCKER_IMAGE%:%DOCKER_TAG%
                docker run -d -p 8081:80 --name html-app %DOCKER_IMAGE%:%DOCKER_TAG%
                '''
            }
        }
    }

    post {
        always {
            bat 'docker logout'
        }
    }
}
