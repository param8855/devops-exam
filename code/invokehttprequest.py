import http.client,urllib.parse
import os

def lambda_handler(event,context):
    subnet_id = os.environ.get("subnet_id")
    conn = http.client.HTTPSConnection('ij92qpvpma.execute-api.eu-west-1.amazonaws.com/')

    params = urllib.parse.urlencode({ "@event": "context"})
    conn.request("POST","/candidate-email_serverless_lambda_stage/data",params,headers={'X-Siemens-Auth': 'test'})
    
    response = conn.getresponse()
    print(response.read().decode())
    return response.json()


