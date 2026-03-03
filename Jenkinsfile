pipeline {
    agent{label 'JAVA'} //if multi node/agents ->'JAVA','JAVA2','JAVA3'...
    triggers {
        pollSCM('* * * * *')         //instead of pollSCM we can also use upstream,cron,githubpush
    }                               //the java is label name inisde jenkins so here also must match
    stages{
        stage('git checkout') {
            steps{
                git url : 'https://github.com/Naveen-Jampala/spring-petclinic.git',
                 branch : 'main'
            }
        }
        stage('build & scan') {
            steps{
              withCrendentials([string(credentialsId: 'sonar_id',variable:'SONAR_TOKEN')]) {
                    withSonarQubeEnv('SONAR') {
                    sh """mvn package sonar:sonar \
                         -Dsonar.projectKey=JAVA-SPC_spring-petclinic \
                         -Dsonar.organization=java-spc \
                         -Dsonar.host.url=https://sonarcloud.io \  
                         -Dsonar.login=$SONAR_TOKEN """
                    }
                }
            }
        }
    }
}
