"""
Testing for AI Runtime Security (AIRS) API
"""

import os
import json
import requests


API_KEY = os.environ.get('AIRS_API_KEY')
URL = "https://service.api.aisecurity.paloaltonetworks.com/v1/scan/sync/request"


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
print(json.dumps(json_data, indent=4))
