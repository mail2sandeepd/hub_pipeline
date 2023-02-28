pipeline {
  agent any

  environment {
    DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
    DOCKER_IMAGE_NAME = 'mail2sandeepd/my-docker-image'
    DOCKER_IMAGE_TAG = 'latest'
  }

  stages {
    stage('Build Docker Image') {
      steps {
        script {
          def dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", "-f Dockerfile .")
          dockerImage.push()
        }
      }
    }

    stage('Push Docker Image to Docker Hub') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
            def dockerImage = docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
            dockerImage.push()
          }
        }
      }
    }
  }
}
