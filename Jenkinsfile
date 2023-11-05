pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                sh '''
                echo "Executing Terraform Init"
                terraform init
                '''
            }
        }
        stage("TF Validate"){
            steps{
                sh '''
                echo "Executing Terraform Init"
                terraform validate
                '''
            }
        }
        stage("TF Plan"){
            steps{
                sh '''
                echo "Executing Terraform Plan"
                terraform plan
                '''
            }
        }
        stage("TF Apply"){
            steps{
                sh '''
                echo "Executing Terraform Apply"
                terraform apply --auto-approve
                '''
            }
        }
        stage("Invoke Lambda"){
            steps{
                sh '''
                echo "Invoking your AWS Lambda"
                aws lambda invoke --function-name invoke_http_request2 --cli-binary-format raw-in-base64-out --payload '{ "subnet_id": "subnet-1a","name": "addala paramasiva","email": "addala.paramasiva55@gmail.com"}' out --log-type Tail --query 'LogResult' --output text |  base64 -d   
                ''' 
            }
            
        }
    }
}
