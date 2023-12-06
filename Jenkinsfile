pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Use 'script' block to execute multiple steps
                    node {

                        // Build Docker image
                        def customImage = docker.build("my-image:${env.BUILD_ID}", "-f .")

                    }
                }
            }
        }
    }
}
