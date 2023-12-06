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
                        //pushing image to dockerhub
                        customImage.push()
       
                }
            }
        }
        stage('Test'){
            steps{
                script{
                      def containerId = docker.image("jsdock:${env.BUILD_ID}") .run("-d -p 8080:80 --name jsdockTest")  
                }

            }

        }

    }
}
