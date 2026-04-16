pipeline {
    agent any

    environment {
        // Using your specific variables
        DOCKERHUB_CREDENTIALS = 'docker_credentials_c2'
        IMAGE_NAME = 'samruddhics/hello-java'
    }

    stages {
        stage('Build Java Application') {
            steps {
                // Compiles the file in the workspace
                bat 'javac HelloWorld.java'
            }
        }

        stage('Run Java Program') {
            steps {
                // Verification step to see output in Jenkins logs
                bat 'java HelloWorld'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Building the image using the Dockerfile in your repo
                bat "docker build -t %IMAGE_NAME%:latest ."
            }
        }

        stage('Login and Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "docker_credentials_c2",
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    // Login using the credentials defined in Jenkins
                    bat 'echo %PASS%| docker login -u %USER% --password-stdin'
                    
                    // Push the image to your repository
                    bat "docker push %IMAGE_NAME%:latest"
                }
            }
        }
    }

    post {
        always {
            // Optional: Logout and clean up local image to save space
            bat 'docker logout'
            // bat "docker rmi %IMAGE_NAME%:latest"
        }
    }
}
