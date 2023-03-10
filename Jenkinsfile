pipeline {
    agent any
    environment {
            DOCKERHUB_CREDENTIALS=credentials("ec97f02a-096a-41d0-9084-800bbb992563")
            CONTAINER_NAME= "team2frontend"
    }
   


   
    stages{
        
        stage("Verify it builds "){
            steps{
                sh "npm install"
            }
            
        }

        stage("Verify valid login"){
            steps {
			    sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"

            }

        }
        stage("Build docker images") {
            steps {
                 
                script {
                    def TAG = "dev"
                    if(BRANCH_NAME == "main"){
                        TAG="prod"
                        // sh "export ENV_TAG="prod""
                    }else if(BRANCH_NAME == "Test"){
                        println("In test")
                        TAG="tst"
                        // sh "export ENV_TAG=tst"
                    }

                    sh "docker build --tag $CONTAINER_NAME:${TAG} ."


                }

            }
            
        }

       

        stage("Push to dockerhub") {
           
            steps{
                script {
                    def TAG = "dev"
                    if(BRANCH_NAME == "main"){
                        TAG="prod"
                        // sh "export ENV_TAG="prod""
                    }else if(BRANCH_NAME == "Test"){
                        println("In test")
                        TAG="tst"
                        // sh "export ENV_TAG=tst"
                    }

                    echo "Pushing to dockerhub"
                    sh "docker tag $CONTAINER_NAME:${TAG} ravenjolly/$CONTAINER_NAME:${TAG}"
                    sh "docker push ravenjolly/$CONTAINER_NAME:${TAG}"

                }
               

            }
        }

        

        stage("Deploy"){
            steps {
                script {
                    def TAG = "dev"
                    if(BRANCH_NAME == "main"){
                        TAG="prod"
                        // sh "export ENV_TAG="prod""
                    }else if(BRANCH_NAME == "Test"){
                        println("In test")
                        TAG="tst"
                        // sh "export ENV_TAG=tst"
                    }


                    if(BRANCH_NAME == "Test"){
                        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS'){
                            sh "docker stop $CONTAINER_NAME"
                            sh "docker container rm $CONTAINER_NAME"
                            sh "docker network create mccnetwork --driver=bridge"
                        }
                        sh "docker run -d --name $CONTAINER_NAME --network mccnetwork -p 3000:80 --expose 80 --env REACT_APP_API_IP=team2data:8080 --env REACT_APP_AUTH_IP=team2auth:8081 $CONTAINER_NAME:${TAG}"

                    }else if(BRANCH_NAME == "main"){
                        //deploy to kuberentes
                        sh "eval \$(minikube docker-env)"
                        catchError(buildResult: "SUCCESS", stageResult: "SUCCESS") {
                            sh "kubectl delete deployment $CONTAINER_NAME"     	
                            sh "kubectl delete service $CONTAINER_NAME"   
    	                }
                        sh "kubectl create deployment $CONTAINER_NAME --image ravenjolly/$CONTAINER_NAME:${TAG}"
                        sh "kubectl expose deployment $CONTAINER_NAME --type=LoadBalancer --port=8080"
                        sh "kubectl set env deployment/$CONTAINER_NAME REACT_APP_AUTH_IP=team2auth:8081"
                        sh "kubectl set env deployment/$CONTAINER_NAME REACT_APP_API_IP=team2data:8080"

                    }
                }
            }


        }


        stage("User Acceptance Test - Front End") {
            steps{
                script {
                    def response= input message: "Is this build good to go to test?",
                    parameters: [choice(choices: "Yes\nNo", 
                    description: "", name: "Pass")]
                    
                    if(response=="Yes") {
                        
                    }else{
                        error("Build rejected.")
                    }
                }
            }
            
            
        }


    }
    post {
        always {
            script {
                if (getContext(hudson.FilePath)) {
                    sh "docker logout"
                }

            }
        }
    }



}