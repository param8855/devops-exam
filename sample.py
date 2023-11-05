import http.client,urllib.parse
host = "ij92qpvpma.execute-api.eu-west-1.amazonaws.com"
conn = http.client.HTTPSConnection(host)

payload = urllib.parse.urlencode({
  "subnet_id": "<Your Private Subnet ID>"
})
conn.request("POST", "/candidate-email_serverless_lambda_stage/data",payload, headers={'X-Siemens-Auth': 'test'})
response = conn.getresponse()
print(response.status, response.reason)

