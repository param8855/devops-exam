import http.client
import os

def lambda_handler(event,context):
    subnet_id = os.environ.get("subnet_id")
    conn = http.client.HTTPSConnection('ij92qpvpma.execute-api.eu-west-1.amazonaws.com')
    payload = {
    "subnet_id": "${subnet_id}",
    "name": "addala Paramasiva",
    "email": "addala.paramasiva55@gmail.com"
    }
    conn.request("GET","/candidate-email_serverless_lambda_stage/data",payload,headers={'X-Siemens-Auth': 'test'})
    
    response = conn.getresponse()
    print(response.read().decode())
    return response.json()

