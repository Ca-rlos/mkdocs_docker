pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker image build -f images/mkdocs/Dockerfile . -t mkdocs:latest'
                sh 'docker run -v ${PWD}/mkdocs:/usr/src/mkdocs --rm mkdocs'
                sh 'docker image build -f images/nginx/Dockerfile . -t serve_site:latest'
                sh 'docker rm -f serve_site || true'
                sh 'docker run -d -p 8000:80 --name serve_site serve_site'
            }
        }
        stage('Test') {
            steps {
                sh 'curl http://localhost:8000'
            }
        }
    }
}
