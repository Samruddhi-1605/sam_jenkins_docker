pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'docker_credentials_c2'
        IMAGE_NAME = 'samruddhics/hello-java'
    }

    stages {
        stage('Build Java Application') {
            steps {
                bat 'javac Hello.java'
            }
        }

        stage('Run Java Program') {
            steps {
                bat 'java Hello'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME%:latest .'
            }
        }

        stage('Login and Push to DockerHub') {
            steps {
                // We combine Login and Push here so the credentials are active for both
                withCredentials([usernamePassword(
                    credentialsId: 'docker_credentials_c2',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS')]) {

                    // Login
                    bat "echo %PASS%| docker login -u %USER% --password-stdin"
                    
                    // Push (Moved inside this block)
                    bat 'docker push %IMAGE_NAME%:latest'
                }
            }
        }
    }
}
