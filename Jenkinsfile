pipeline {

  /*
  * dockerhub  credentials should be configured on jenkins server
  * i'm using jenkins declarative pipeline
  * jenkins E-main notification should be configured on jenkins server
  */

  agent any

  environment {
    dockerImage = ''
    registry = "abdallaabdelsalam/app"
    registryCredential = 'docker-hub-id'
    pipelineEmail = 'testingfeature101@gmail.com'

  }

  stages {
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build(registry + ":$BUILD_NUMBER")
        }
      }
    post {  
        success {  
             echo 'successfully, build docker image'  
          }  
        failure {  
            echo "can't build docker image"
          }  
      }
    }

    stage('Push the Image to Dockerhub') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
       post {  
        success {  
             echo 'successfully, pushed docker image to dockerhub'  
          }  
        failure {  
            echo "can't push docker image to dockerhub"
          }  
      }
    }

    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    
  }
   post {  
        success {  
             echo 'congrats, another successful build !!'
             mail bcc: '', body: "<b>successful build</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> build URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Project name -> ${env.JOB_NAME}", to: "$pipelineEmail";  
          }  
        failure {
            echo 'build failed !!'    
            mail bcc: '', body: "<b>build failed</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> build URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "$pipelineEmail";
          }  
      }
}