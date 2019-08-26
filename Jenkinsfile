pipeline {
  agent any
      
  tools {
    maven 'M3'
    jdk 'JDK8'
    git 'Default'   
  }

  triggers {
    pollSCM('H/2 9-18 * * 1-5')
  }

  stages {
     stage('Git Clone') {
       steps  {
         git 'https://github.com/tusharnagarro/SpringDockerJenkins.git'
       }
     }

    stage('Clean') {
      steps {
        script {
          if (isUnix()) {
            sh 'mvn clean'
          } else {
            bat 'mvn clean'
          }
         }
       }
     }

     stage('Build') {
       // Run the maven build
      steps {
        script {
          if (isUnix()) {
            sh 'mvn package'
            stash includes: '**/target/*.war', name: 'warfile'
          } else {
            bat 'mvn package'
            stash includes: '**/target/*.war', name: 'warfile'
           }
         }
       }
     }

     stage('Test') {
       // Run the maven test
      steps {
        script {
          if (isUnix()) {
            sh 'mvn test'
          } else {
            bat 'mvn test'
          }
        }
      }
    }

     stage('Sonar Analysis') {
      // Run the sonar analysis
      steps {
        script {
            withSonarQubeEnv("Sonar") {
                if (isUnix()) {
                    sh 'mvn sonar:sonar -Dsonar.projectName=SpringDockerJenkins -Dsonar.projectKey=tushar'
                } else {    
                    bat 'mvn sonar:sonar -Dsonar.projectName=SpringDockerJenkins -Dsonar.projectKey=tushar'
                }
            }
        }
      }
     }

     stage("Quality Gate"){
         // Check for Sonar quality gate
         steps{
            script{
                def qg = waitForQualityGate() 
                if (qg.status != 'OK') {
                    error "Pipeline aborted due to quality gate failure: ${qg.status}"
                }
            }
        }
     }

     stage('Artifactory Upload') {
        // Upload .war file to artifactory server
        steps {
            script {
              def server = Artifactory.server('123@artifactory')
              def buildInfo = Artifactory.newBuildInfo()
              buildInfo.env.capture = true
              buildInfo.env.collect()
              def rtMaven = Artifactory.newMavenBuild()
              rtMaven.tool = 'M3'
              rtMaven.deployer server: server, releaseRepo: 'nagp', snapshotRepo: 'nagp'
              rtMaven.deployer.artifactDeploymentPatterns.addInclude("*.war")
              rtMaven.run pom: 'pom.xml', goals: 'clean package', buildInfo: buildInfo
              server.publishBuildInfo buildInfo
            }
        }
     }
     
     stage('Create Docker Image') {
       //Create docker image
       steps {
         script {
            if (isUnix()) {
                    //sh 'sudo service docker start'
                    sh 'sudo pwd'
                    sh returnStdout: true, script: '/bin/docker image build -t tusharkumar886/springdockerjenkins:latest .'       
            } else {
                //bat 'net start com.docker.service'
                //bat script: '\"C:\\Program Files\\Docker\\Docker\\Docker for Windows.exe\"'
                bat 'docker image build -t tusharkumar886/springdockerjenkins:latest .'
            }
            unstash 'warfile'
        }
       }
     }

     stage('Docker Image Push') {
        // Push docker image now
        steps {
             script {
                 withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USER')]) {
                    if(isUnix()){
                        sh """docker login -u='$USER' -p='$PASSWORD' """
                        docker.withRegistry('', 'docker') {                        
                          sh returnStdout: true, script: 'docker push tusharkumar886/springdockerjenkins:latest'
                        }                    
                    } else {
                        bat "docker login -u $USER -p $PASSWORD"
                        docker.withRegistry('', 'docker') {
                            bat "docker push $USER/springdockerjenkins:latest"
                        }
                    } 
                 }    
             }
         }
     }

     stage('Docker Deployment') { 
       // Deploy docker image on port 8082
         steps {
             script {
                 if(isUnix()){
                    sh '''
                      ContainerId=$(docker ps | grep 8082 | cut -d " " -f 1)
                      if [ ! -z $ContainerId]
                      then
                          docker stop $ContainerId
                          docker rm -f $ContainerId
                      fi
                    ''' 
                    // sh returnStdout: true, script: '/bin/docker container stop springdockerjenkins'
                    sh returnStdout: true, script: '/bin/docker run --name springdockerjenkins --publish 8082:8080 tusharkumar886/springdockerjenkins:latest'
                 } else {
                     bat '''
                        for /F "tokens=1" %%a in (\'docker ps -q --filter "name=springdockerjenkins"\') DO (set ContainerId=%%a)
                        if [%ContainerId%] neq [] (cmd /c docker rm -f %ContainerId%)
                    '''
                    bat 'docker run --name springdockerjenkins -d -p 8082:8080 tusharkumar886/springdockerjenkins:latest'
                    echo  " ACCESS DEV ENVIRONMENT HERE: http://localhost:8082/SpringDockerJenkins/"
                 }
             }
         }
     }
   }

}