pipeline {
    agent any
    stages {
        stage('Build Nimble Survey') {
            when { changeRequest() }
            steps {
                echo 'BUILDING'
            }
        }
    }
}