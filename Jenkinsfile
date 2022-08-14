pipeline {
    agent any
    stages {
        stage('Build Nimble Survey') {
            when { environment name: 'VERIFYING_PULL_REQUEST', value: "true" }
            steps {
                echo 'BUILDING'
            }
        }
    }
}