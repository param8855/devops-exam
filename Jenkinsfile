pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                terraform init
            }
        }
        stage("TF Validate"){
            steps{
                terraform validate
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
                terraform plan
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
                // terraform apply --auto-approve
            }
        }
        stage("Invoke Lambda"){
            steps{

                echo "Invoking your AWS Lambda"
                // aws lambda invoke --function-name invoke_http_request out --log-type Tail --query 'LogResult' --output text |  base64 -d    
            }
        }
    }
}
