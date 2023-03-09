pipeline {
    agent { label 'agent2'}

    tools {
        // Install the Maven version configured as "maven" and add it to the path.
        maven "maven"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                sh "docker stop tomcat9"
                sh "docker rmi tomcat:9.0"
                sh "docker rmi mywebapp"
                git 'https://github.com/shwetketu/maven_default.git'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
                sh 'cp /var/lib/jenkins/workspace/CICD_Job/target/sample.war /opt/jenkins/maven_default/ROOT.war'

            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                 //   archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh "docker build -t mywebapp ."
                sh "docker run -itd --rm --name tomcat9 -p 9090:8080 mywebapp"
            }
        }
    }
}

