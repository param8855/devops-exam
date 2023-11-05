import http.client,urllib.parse
import os

def lambda_handler():
    subnet_id = os.environ.get("subnet_id")
    conn = http.client.HTTPSConnection('ij92qpvpma.execute-api.eu-west-1.amazonaws.com/')
    
    payload = urllib.parse.urlencode({ "subnet_id": "subnet-1a","name": "addala paramasiva","email": "addala.paramasiva55@gmail.com"})
    
    conn.request("POST","/candidate-email_serverless_lambda_stage/data", payload,headers={'X-Siemens-Auth': 'test'})
    
    response = conn.getresponse()
    print(response.read().decode())
    return response.json()


