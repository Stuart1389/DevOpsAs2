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
        	        def customImage = docker.build("jsdock:${env.BUILD_ID}")      	    
        	}           
        }

    }
}
