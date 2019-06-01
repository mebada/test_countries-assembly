pipeline {
    agent { label 'master' }
    stages {
        stage('Download JAR') {
           steps {
               println("Checkout existing JARS from interview-test repo. ") 
               dir('interview-test'){
                   git branch: 'master',
                   url: 'https://git@github.com/SlashTec/interview-test.git'
               } 
               script {
                   def fileName = "countries-assembly-1.0.1.jar"
                   def expectedSHA1 = "92bf1a691fc6dc835b21e0d74102c41ad84635f9"
                   sh "echo ${fileName}" 
                   sha1sum = sh(returnStdout: true, script: "sha1sum interview-test/${fileName}")
                   print sha1sum
                   if (sha1sum.contains("${expectedSHA1}")){
                     println("sha1 check passed")
                     println("Updating Docker File")
                     def text = readFile "docker/Dockerfile"
                          
                     writeFile(file: "docker/Dockerfile", text: text.replaceAll("countries-assembly-x.jar", "${fileName}") , encoding: "UTF-8") 
                     sh "cat docker/Dockerfile"  
                    
                    } else {
                      println("sha2 check failed")
                      error "This pipeline stops here!"
                   }
               } //end of script
                 
           } //end of steps
        } // end of stage  
        
        stage('Build Docker Image') {
            steps {
               script{
                    //sh "minikube start"
                     sh "eval \$(minikube docker-env) && docker build -t test_countries-assembly:v1  -f docker/Dockerfile . "
                     sh "kubectl cluster-info"
               }
            
            }
        } 
        stage('Deployment') {
            steps {
               script{
                     sh "helm init"


                     sh "helm upgrade dev-airports-assembly  kubernetes/countries-assembly/  --install --recreate-pods --force"
                     sh "kubectl get pods"
               }
            
            }
        } 
    } //end of stages
} // end of pipeline
