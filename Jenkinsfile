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
                        //building image from docker file
                        def customImage = docker.build("jsdock:${env.BUILD_ID}")
                }
            }
        }
        stage('Create container'){
            steps{
                script{
                      //creating container from image
                      def containerId = docker.image("jsdock:${env.BUILD_ID}") .run("-p 8090:8090 --name jsdockTest${env.BUILD_ID}")
                }

            }

        }

          stage('Test container'){
            steps{
                script{
                      //copying content from server.js
                      sh "wget http://52.91.144.228:8090/"
                      sh "cat index.html"
                }

            }

        }

        stage('push image'){
            steps{
                script{
                      //push image to dockerhub
                      withCredentials([usernamePassword(credentialsId: 'theHub')]) {
                        sh "docker login -u $USERNAME -p $PASSWORD"                                                                                                                                         
                  }

                }

            }

        }


        stage('Clean up'){
            steps{
                script{
                    //stopping and removing container
                    sh "docker stop jsdockTest${env.BUILD_ID}"
                    sh "docker rm jsdockTest${env.BUILD_ID}"
                }

            }

        }
    }
}
