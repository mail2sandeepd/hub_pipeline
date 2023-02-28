pipeline {
    agent any
	
	environment {
    DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
    DOCKER_IMAGE_NAME = 'mail2sandeepd/my-docker-image'
    DOCKER_IMAGE_TAG = 'latest'
  }
	
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" .'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    sh 'docker push "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" '
                }
            }
        }
    }
}
