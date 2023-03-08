

node {
    
    stage ("Checkout React Client"){
        git branch: 'main', url: 'https://github.com/ravenjolly/team2foxreactday6.git'
    }
    
     stage("Set minikube environment"){
        sh "minikube docker-env"
        sh "eval \$(minikube -p minikube docker-env)"
        
    }
    stage ("Containerize the app-docker build - react client") {
        sh 'docker build --rm -t team2frontend:v1.0 .'       
        sh 'minikube image load team2frontend:v1.0'        
        
    }
    
    
    stage ("Inspect the docker image - react client"){
        sh "docker images team2frontend"
        //sh "docker inspect team2frontend"
    }
    
    
    
    stage("Remove previous deployment"){
         catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS')  {
            	sh "kubectl delete deployment team2frontend"     	
            	sh "kubectl delete service team2frontend"   
    	    }
    }
    

    stage ("Deploy to the kube"){
    	
    
			sh "kubectl create deployment team2frontend --image team2frontend:v1.0"
    	    sh "kubectl expose deployment team2frontend --type=LoadBalancer --port=80"
    	    sh "kubectl set env deployment/team2frontend REACT_APP_AUTH_IP=team2auth:8081"
    	    sh "kubectl set env deployment/team2frontend REACT_APP_API_IP=team2data:8080"   
    }
    
    
    /**
    
    
   
    stage ("Run Docker container instance - react client"){
    	steps{
    	    catchError {
            	sh "docker container rm team2frontend "     	   
    	    }
    	    catchError{
    	        sh "docker network create --driver bridge mccnetwork"
    	    }
    	    sh "docker run -d --name team2frontend --network mccnetwork -p 3000:80 --expose 80 --env REACT_APP_API_IP=team2data:8080 --env REACT_APP_AUTH_IP=team2auth:8081 team2frontend:v1.0"
    	}

    }
    */
}
    