pipeline {
    agent any

    // Étape 5 : Paramètres
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'test', 'prod'], description: 'L\'environnement cible')
    }

    // Étape 7 : Nettoyage automatique avant le build (via options ou stage clean)
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages {
        // Étape 7 (Alternative explicite)
        stage('Nettoyage Workspace') {
            steps {
                cleanWs()
                echo "Workspace nettoyé."
            }
        }

        stage('Checkout & Setup') {
            steps {
                sh '''
                    if [ ! -f junit-platform-console-standalone-1.9.3.jar ]; then
                        echo "Téléchargement de JUnit avec curl..."
                        curl -L -o junit-platform-console-standalone-1.9.3.jar https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.9.3/junit-platform-console-standalone-1.9.3.jar
                    fi
                '''
            }
        }

        stage('Compilation') {
            steps {
                // Étape 2 : Compilation
                sh 'mkdir -p out'
                sh 'javac -d out -cp junit-platform-console-standalone-1.9.3.jar:. Factorial.java FactorialTest.java'
            }
        }

        stage('Tests Unitaires') {
            steps {
                // Étape 3 : Tests
                sh 'java -jar junit-platform-console-standalone-1.9.3.jar -cp out --scan-classpath'
            }
        }

        stage('Packaging') {
            steps {
                // Étape 4 : Génération JAR
                sh 'echo "Main-Class: Factorial" > Manifest.txt'
                sh 'jar cfm factorial-app.jar Manifest.txt -C out .'
                archiveArtifacts artifacts: 'factorial-app.jar', fingerprint: true
            }
        }

        // Étape 6 : Conditions (When)
        stage('Déploiement Prod') {
            when {
                expression { params.ENVIRONMENT == 'prod' }
            }
            steps {
                echo "Déploiement vers l'environnement de PRODUCTION..."
                sh 'sleep 2'
            }
        }
    }
    
    post {
        always {
            echo 'Le pipeline est terminé.'
        }
        failure {
            echo 'Le build a échoué ! Vérifiez les logs.'
        }
    }
}