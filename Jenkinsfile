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
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh "echo $DOCKERHUB_PASSWORD | docker login --username $DOCKERHUB_USERNAME --password-stdin"
                    sh 'docker push "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" '
                }
            }
        }
		stage('Deploy application to Kubernetes') {
            steps {
                withCredentials([kubeconfig(credentialsId: 'kubernetes-config', variable: 'KUBECONFIG')]) {
                    sh "export IMAGE_NAME=$IMAGE_NAME && export KUBECONFIG=$KUBECONFIG && envsubst < kubernetes-deployment.yaml | kubectl apply -f -"
                }
            }
        }
    }
}
