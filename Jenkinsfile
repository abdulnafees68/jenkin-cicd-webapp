@Library('shared') _  // Import shared library

pipeline {
    agent { label "nafees" }
    environment {
        DOCKER_COMPOSE = '/usr/local/bin/docker-compose'  // Adjust if necessary
    }
    stages {
        stage("hello") {
            steps {
                script {
                    hello()  // This will call the hello() function from the shared library
                }
            }
        }
        stage('Clone Repository') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/abdulnafees68/jenkin-cicd-webapp.git', branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t hello-angular-app:latest .'
            }
        }
        stage('Remove Old Containers') {
            steps {
                echo 'Stopping and removing old containers...'
                sh '''
                    docker-compose down || true  # Stop and remove old containers
                    docker ps -q --filter "expose=9000" | xargs -r docker stop  # Stop any container using port 9000
                    docker system prune -f  # Optionally clean up unused resources
                '''
            }
        }
        stage('Run Docker Container') {
            steps {
                echo 'Running new Docker container...'
                sh 'docker-compose up -d'  // Starts the container in detached mode
            }
        }
    }
}
