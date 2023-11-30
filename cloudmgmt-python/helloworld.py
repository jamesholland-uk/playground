##########################################
# First tests with Cloud Mgmt for NGFWs
##########################################

import requests
from requests.auth import HTTPBasicAuth
import os
import json

###############
# Get a token
###############

# Define creds for Cloud Mgmt through environment variables, for example:
# export CLOUDMGMT_TSG=1234567890
# export CLOUDMGMT_CLIENT_ID=myaccount@1234567890.iam.panserviceaccount.com
# export CLOUDMGMT_CLIENT_SECRET=1234-567-890-1234
TSG = os.environ.get("CLOUDMGMT_TSG")
CLIENT_ID = os.environ.get("CLOUDMGMT_CLIENT_ID")
CLIENT_SECRET = os.environ.get("CLOUDMGMT_CLIENT_SECRET")

url = "https://auth.apps.paloaltonetworks.com/auth/v1/oauth2/access_token"
payload = "grant_type=client_credentials&scope=tsg_id:" + TSG
headers = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Accept': 'application/json'
}
basic = HTTPBasicAuth(CLIENT_ID, CLIENT_SECRET)

response = requests.request("POST", url, headers=headers, data=payload, auth=basic)
# print(response.text)

parsed_response = json.loads(response.text)
the_token = parsed_response['access_token']
# print(the_token)

##############################
# Create an address object
##############################

folder="gcp-vm-series"
obj_name = "test-obj-01"
obj_desc = "From CloudMgmt API"
obj_value = "10.10.10.1"
url = "https://api.sase.paloaltonetworks.com/sse/config/v1/addresses?folder=" + folder

payload = json.dumps({
  "description": obj_desc,
  "name": obj_value,
  "ip_netmask": obj_value
})
headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ' + the_token
}

response = requests.request("POST", url, headers=headers, data=payload)
print(response.text)

##############################
# Push the config to NGFWs
##############################

url = "https://api.sase.paloaltonetworks.com/sse/config/v1/config-versions/candidate:push"

payload = json.dumps({
  "description": "Puuuuuush",
  "folders": [
    folder
  ]
})
headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ' + the_token
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)
