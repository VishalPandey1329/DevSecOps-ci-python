pipeline {
    agent any

    environment {
        // change this if repo name changes
        GITHUB_REPO = "vishalpandey1329/devsecops-ci-python"
        REGISTRY    = "ghcr.io"
        IMAGE_NAME  = "${REGISTRY}/${GITHUB_REPO}:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set up Python & Dependencies') {
            steps {
                sh '''
                    python3 --version || sudo apt-get update && sudo apt-get install -y python3 python3-pip
                    python3 -m pip install --upgrade pip
                    if [ -f requirements.txt ]; then python3 -m pip install -r requirements.txt; fi
                    python3 -m pip install pytest bandit
                '''
            }
        }

        stage('Run Tests (pytest)') {
            steps {
                sh '''
                    echo "Running pytest..."
                    pytest
                '''
            }
        }

        stage('Security Scan (Bandit)') {
            steps {
                sh '''
                    echo "Running Bandit security scan..."
                    bandit -r app -ll || true
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    echo "Building Docker image ${IMAGE_NAME}"
                    docker build -t "${IMAGE_NAME}" .
                '''
            }
        }

        stage('Push Image to GHCR') {
            steps {
                withCredentials([string(credentialsId: 'ghcr-token', variable: 'GHCR_TOKEN')]) {
                    sh '''
                        echo "${GHCR_TOKEN}" | docker login ghcr.io -u "${GITHUB_REPO%%/*}" --password-stdin
                        echo "Pushing ${IMAGE_NAME}"
                        docker push "${IMAGE_NAME}"
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Jenkins DevSecOps pipeline finished.'
        }
    }
}
