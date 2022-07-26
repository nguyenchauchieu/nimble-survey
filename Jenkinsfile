pipeline {
    agent any
    stages {
        stage('Parallel Stages') {
            parallel {
        stage('First Stage') {
            steps {
                sleep 5
                echo 'This is First Step'
            }
        }
        stage('Second Stage') {
            steps {
                echo 'This is Second Step'
            }
        }
    }
        }
    }
}