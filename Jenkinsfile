node {
    
    stage ("Checkout React Client"){
        git branch: 'main', url: 'https://github.com/ravenjolly/team2foxreactday6.git'
    }
    
    
    stage ("Containerize the app-docker build - react client") {
        sh 'docker build --rm -t team2frontend:v1.0 .'
    }
    
    stage ("Inspect the docker image - react client"){
        sh "docker images team2frontend"
        sh "docker inspect team2frontend"
    }
    
   
    stage ("Run Docker container instance - react client"){
    	// I dont care if it exists remove it
    	sh "bash 'docker inspect container team2frontend || docker container rm team2frontend || true'>/dev/null 2>&1  " 
    	sh "docker network inspect mccnetwork >/dev/null 2>&1 ||docker network create --driver bridge mccnetwork"
    	
    	///run it then
        sh "docker run -d --name team2frontend --network mccnetwork -p 3000:80 --expose 80 --env REACT_APP_API_IP=team2data:8080 --env REACT_APP_AUTH_IP=team2auth:8081 team2frontend:v1.0"
    }
	 
	
}
    