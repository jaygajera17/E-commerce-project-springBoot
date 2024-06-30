pipeline {
    agent any

    environment {
        // Define any environment variables here
        PROJECT_NAME = "E-commerce-project-springBoot"
        GITHUB_REPO_URL = "https://github.com/jaygajera17/E-commerce-project-springBoot.git"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub repository
                git url: "${GITHUB_REPO_URL}", branch: 'main'
            }
        }
        
        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            steps {
                // Run the tests
                sh 'mvn test'
            }
        }
        
        stage('Deploy') {
            steps {
                // Deploy the application (this can be customized as per your deployment process)
                // For example, copying the built JAR file to a specific location, or deploying to a cloud service
                sh '''
                echo "Deploying application..."
                # Example command: copying the built JAR file to a remote server
                # scp target/*.jar user@remote-server:/path/to/deployment/directory
                '''
            }
        }
    }
    
    post {
        always {
            // Actions to perform at the end of the pipeline
            // For example, cleaning up workspace, sending notifications, etc.
            cleanWs()
        }
        success {
            // Actions to perform if the pipeline succeeds
            echo 'Pipeline succeeded!'
        }
        failure {
            // Actions to perform if the pipeline fails
            echo 'Pipeline failed!'
        }
    }
}
