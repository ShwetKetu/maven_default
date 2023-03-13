pipeline {
    agent { label 'ansible'}

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                sh "sudo chmod -R 777 /var/run/docker.sock"
                sh "docker stop tomcat9 || true"
                sh "docker rmi tomcat:9.0 || true"
                sh "docker rmi mywebapp || true"
                git 'https://github.com/shwetketu/maven_default.git'

                // Run Maven on a Unix agent.
                sh "rm -rf /opt/jenkins/maven_default/ROOT.war || true"
                sh "rm -rf /var/lib/jenkins/workspace/CICD_Job/target/sample.war || true"
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
                sh "ansible-playbook /opt/jenkins/maven_default/build_run_docker.yaml"
            }
        }
    }
}

