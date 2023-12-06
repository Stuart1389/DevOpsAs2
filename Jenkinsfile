pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('build'){
        	steps{
        	    node{
        	        def customImage = docker.build("my-image:${env.BUILD_ID}")
        	    }
        	}           
        }

    }
}
