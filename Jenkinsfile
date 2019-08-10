  pipeline {
    agent any
    environment{  
      scmUrl = "git@github.com:kiranraj4me/AWS_EB_INFRA.git"
      scmBranch = "${env.BRANCH_NAME}" 
      shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'")
      commitId = sh(returnStdout: true, script: "git rev-parse --short HEAD") 
        
          }

      
stages {
        stage('Clear Workspace') {
            steps {
                cleanWs()
                         
            }
        }
        stage('Build') {
         environment{
           branchname = "${env.BRANCH_NAME}"
         }
            steps {
                   dir('source') {
                 
                git branch: scmBranch, credentialsId: '48553e38-f071-4dc4-b41c-6be28f1b1f72', url: scmUrl
               }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                      sh 'whoami && pwd'
                      sh 'ls -ls /var/terraform/eb_app_$scmBranch/'
                      sh 'cp /var/terraform/eb_app_$scmBranch/terraform.tfstate source/'
                      sh 'cd source  && terraform init && terraform plan -var env=$scmBranch && terraform apply -var env=$scmBranch -auto-approve'

            }
        }
        stage('Save') {
            steps {
                echo 'Saving tfstate....'
                      sh 'mkdir -pv /var/terraform/eb_app_$scmBranch'
                      sh 'mv source/terraform.tfstate /var/terraform/eb_app_$scmBranch/'
            }
        }
    }

  }
