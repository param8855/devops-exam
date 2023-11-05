import os
import requests
import json
import urllib3
def handler(event, context):
    url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
    headers = {
        "X-Siemens-Auth": "test"
    }
    payload = {
        "subnet_id": os.environ.get("subnet_id"),
        "name": "paramasiva",
        "email": "addala.paramasiva55@gmail.com"
    }

    response = requests.post(url, headers=headers, json=payload)
    return response.json()

