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
                        //building from docker file
                        def customImage = docker.build("jsdock:${env.BUILD_ID}")                              
                }
            }
        }
        stage('Test'){
            steps{
                script{
                      def containerId = docker.image("jsdock:${env.BUILD_ID}") .run("-p 8090:8090 --name jsdockTest${env.BUILD_ID}")  
                }

            }

        }
        stage('Clean up'){
            steps{
                script{
                    sh "docker stop jsdockTest${env.BUILD_ID}"
                    sh "docker rm jsdockTest${env.BUILD_ID}"
                }

            }

        }
    }
}
