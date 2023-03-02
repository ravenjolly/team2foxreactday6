node {
    
    stage ("Checkout React Client"){
        git branch: 'main', url: 'https://github.com/foxwas/bah-mcc-react-day6.git'
    }
    
    stage ("Install dependencies - React Client") {
       sh 'npm install'
    }
    
    stage ("Containerize the app-docker build - react client") {
        sh 'docker build --rm -t mcc-react:v1.0 .'
    }
    
    stage ("Inspect the docker image - react client"){
        sh "docker images mcc-react:v1.0"
        sh "docker inspect mcc-react:v1.0"
    }
    
    stage ("Run Docker container instance - react client"){
        sh "docker run -d --rm --name mcc-react -p 3000:80 mcc-react:v1.0"
    }
	 
	stage('User Acceptance Test - react client') {
	
	  def response= input message: 'Is this build good to go?',
	   parameters: [choice(choices: 'Yes\nNo', 
	   description: '', name: 'Pass')]
	
	  if(response=="Yes") {
	    stage('Release  - react client') {
	      sh "docker stop mcc-react"
	      sh "echo MCC react client service is ready to release!"
	    }
	  }
    }
    