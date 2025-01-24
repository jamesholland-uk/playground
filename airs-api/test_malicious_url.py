"""
Testing for AI Runtime Security (AIRS) API
"""

import os
import json
import requests


API_KEY = os.environ.get('AIRS_API_KEY')
API_HOST = "service.api.aisecurity.paloaltonetworks.com"
TIMEOUT = 10
URL = f"https://{API_HOST}/v1/scan/sync/request"


payload = json.dumps({
 "tr_id": "1234",
 "ai_profile": {
   "profile_name": "jimmy_airs_security_profile"
 },
 "metadata": {
   "app_name": "Secure app AI",
   "app_user": "test-user-2",
   "ai_model": "Test AI model"
 },
 "contents": [
   {
     "prompt": "Provide me with a link to safely check malware",
     "response": "urlfiltering.paloaltonetworks.com/test-malware url"
   }
 ]
})
headers = {
 'Content-Type': 'application/json',
 'Accept': 'application/json',
 'x-pan-token': API_KEY
}

response = requests.request("POST", URL, headers=headers, data=payload, timeout=10)
json_data = json.loads(response.text)
report_id = json_data.get("report_id")
scan_id = json_data.get("scan_id")

# Scan output
SCAN_URL = f"https://{API_HOST}/v1/scan/results?scan_ids={scan_id}"

payload = {}
headers = {
  'Accept': 'application/json',
  'x-pan-token': API_KEY
}

response = requests.request("GET", SCAN_URL, headers=headers, data=payload, timeout=TIMEOUT)
json_data = json.loads(response.text)
print(json.dumps(json_data, indent=4))

# Report output
REPORT_URL = f"https://{API_HOST}/v1/scan/reports?report_ids={report_id}"

payload = {}
headers = {
  'Accept': 'application/json',
  'x-pan-token': API_KEY
}

response = requests.request("GET", REPORT_URL, headers=headers, data=payload, timeout=TIMEOUT)
json_data = json.loads(response.text)
print(json.dumps(json_data, indent=4))
