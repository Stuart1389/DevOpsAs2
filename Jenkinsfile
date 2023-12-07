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
                        echo "Creating image from dockerfile"
                        def customImage = docker.build("stuart1389/jsdock:${env.BUILD_ID}")
                }
            }
        }
        stage('Create container'){
            steps{
                script{
                      //creating container from image
                      echo "Creating container from image"
                      def containerId = docker.image("stuart1389/jsdock:${env.BUILD_ID}") .run("-p 8090:8090 --name jsdockTest${env.BUILD_ID}")
                }

            }

        }

          stage('Test container'){
            steps{
                script{
                      //copying content from server.js
                      echo 'Testing container'
                      sh "wget http://54.162.102.237:8090/"
                      sh "cat index.html"
                      echo "ls inside container"
                      sh "docker exec jsdockTest${env.BUILD_ID} ls"
                }

            }

        }

        stage('push image'){
            steps{
                script{
                      echo "Pushing image to dockerhub"
                      //logging into docker
                      withCredentials([usernamePassword(credentialsId: 'theHub', usernameVariable: 'dockerUser', passwordVariable: 'dockerPass')]) {
                        sh "docker login -u $dockerUser -p $dockerPass"
                        
                        //pushing docker image
                        sh "docker push stuart1389/jsdock:${env.BUILD_ID}"
                        
                        // logging out of docker
                        sh "docker logout"                                                                                                                                        
                  }

                }

            }

        }
        
        
        stage('Kubernetes'){
            steps{
                script{
                      echo "Deploying updated image to kubernetes"
                }
                sshagent(['ewSSH']){
                //ssh into production server
                    sh "ssh ubuntu@54.204.209.24"
                    //get image from dockerhub using build id
                    sh "kubectl set image deployment/jsdock jsdock=stuart1389/jsdock:${env.BUILD_ID}"
                }


            }

        }


        stage('Clean up'){
            steps{
                script{
                    echo "stopping and removing container"
                    //stopping and removing container
                    sh "docker stop jsdockTest${env.BUILD_ID}"
                    sh "docker rm jsdockTest${env.BUILD_ID}"
                }

            }

        }
    }
}
