import http.client
import os

def lambda_handler(event, context):
    subnet_id = os.environ.get("subnet_id")
    conn = http.client.HTTPSConnection('ij92qpvpma.execute-api.eu-west-1.amazonaws.com')
    
    headers = {'X-Siemens-Auth': 'test'}
    payload = {
      "subnet_id": "${subnet_id}",
      "name": "Addala Parama Siva",
      "email": "addala.paramasiva55@gmail.com"
    }
    
    conn.request('POST', '/candidate-email_serverless_lambda_stage/data', payload, headers)
    
    response = conn.getresponse()
    print(response.read().decode())
    return response.json()
