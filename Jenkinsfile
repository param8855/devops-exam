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
                terraform state rm 'aws_lambda_function.invoke_http'
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
                aws lambda invoke --function-name invoke_http_request out --log-type Tail --query 'LogResult' --output text |  base64 -d   
                ''' 
            }
            
        }
    }
}
