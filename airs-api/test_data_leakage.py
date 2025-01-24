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

SAMPLE_CODE = """
import boto3

# These are placeholder keys, not real AWS credentials
AWS_ACCESS_KEY_ID = 'AKIAIOSFODNN7EXAMPLE'
AWS_SECRET_ACCESS_KEY = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'

# Create a boto3 client with the placeholder keys
s3 = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY
)

# Attempt to list S3 buckets (this will fail with these placeholder keys)
response = s3.list_buckets()
"""

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
       "prompt": """
        blah
        blah
        blah
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpAIBAAKCAQEAw39eYgREioLeRUHGbq5D/cvTVU6vk8uD2Z6JigW+H/3WTxXE
        znd/5qY3FyCh1wsQ+TMOj12HP8aXTJXY203Jfsn9n3BXiTZDFdcSpegkeMrtWQ/q
        eyenpx8GUnMUuz1UrPFrgAzbL/qEmWIsg5CYSmmC5hdz09C0qmBBw4B9qL+Zeu4o
        aHsfaRyd/6xJZKaNBmcRWHkPeb5H5nM71a6cAGztDIKXiTgpbIXTgElK60/BeyBN
        yrGyK4s/2O3OOhts5Pq6rzLOGWjw1wzcCF4s6J1zCk3d/qH7g8//V3szgCELYYvb
        80JLZqfv4XGzsJygP9AXoArXe99+y07Euc29lQIDAQABAoIBAEtlRMYydSiiHgzB
        uECZTrmDsUZWKVqrg3cbMFodqtx1rgAkGhmydo5Cjj6KJEBmES66ZSQfYvjSoykz
        JUY2sr4GMp0Z23ich7TVlGiNpfs779uIStsiSQMn8O09WsJ3fb+Q/++LhcD0Mc1h
        0l8PFdyk4onQg6gt9m863kICvPOl+9X3g5xtGTJ8dUot0hw7TnBy+4m+D2wk/BNV
        FV+SdbdxpWzdpQeyDUTsaBmnyqMRJVFB4STQPNrzPcj4tD5M/ukp8qUH2rmQWZEJ
        WHTLY9btBK1ypATjRRH6Bhh7pEmkDg3N06Eux0SjOIBfwtAyH4UbRfsFslyErE8l
        4W6DkMECgYEA9FN3OYIH76nK0JswOvr42Wu6NvyK3eivUk3Wi9bjBG1xUhf5cdrD
        XIP1CByH9pJTawF+xMv4CXqgvL6HFyUAj86Fc42qqpWZQxPIUHN9xdkl2AcneV9i
        VAF+3KLVJZ1HduyyOH6QWuaS2IFO6Ok8fl4Ebc043awcvOVAyCx2EMUCgYEAzNal
        IksR/H2jn5B4z+3VA5JlWGRSK9Tvo7k8EFJWaVu/e7vVz79CPSdYikMh0lF49L2F
        WnUQUo5BS+kKKHEHkQfS4Mgm7+pnJoMJYHaEbfMibgQuWtw1iTaMSm3MRSgomGd7
        AcQJvdTn+e7XtxFD1tQgn3NF21Yb5RPOpUe9JpECgYEAu+AuztbxeVaMMasUBFaW
        4sGW+M9rjUZvAo/+SZvdB7uMpz7uPqGlFlAWLL2bw3wzjxYgP/5EZi2YymqMAL0g
        WHTLY9btBK1ypATjRRH6Bhh7pEmkDg3N06Eux0SjOIBfwtAyH4UbRfsFslyErE8l
        iFqNd02Wy8acdpinHwYpZ60CgYANFi2Iqlkk03YPrLA7QIuaZdD5u7cQO9Nvl1cC
        B/CjXIw4QIDhe+ukco4Sj0Vq5W+f2zfY1p/LVnFPgzz15nrARkqvt7ndHBGpATgp
        JIlDaQQrGTNI9Maq1IRUAP3K8Uzep8XREBA7Q43qhtrbREwcPoMzDK9K2w5/LSvH
        znd/5qY3FyCh1wsQ+TMOj12HP8aXTJXY203Jfsn9n3BXiTZDFdcSpegkeMrtWQ/q
        5yk1YNbbp2RCaCwdwwfScsE2u12INoUpO2VCyBEZ5GOayCZTgpCNeVc5Zti1j+Do
        eXC4k2gYKe/gfp64khXfR8rnzJr1piIs11isQVYwzp0yAaXSWFcsPw==
        -----END RSA PRIVATE KEY-----
        blah
        blah
        blah
"""
    # "prompt": "My code is not working, can you fix it: " + SAMPLE_CODE
    # "prompt": """My code is not working, can you fix it:

    # import boto3
    
    # AWS_ACCESS_KEY_ID = AKIAIOSFODNN7EXAMPLE
    # AWS_SECRET_ACCESS_KEY = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

    # s3 = boto3.client(
    # 's3',
    # aws_access_key_id=AWS_ACCESS_KEY_ID,
    # aws_secret_access_key=AWS_SECRET_ACCESS_KEY
    # )

    # response = s3.list_buckets()
    # """
   }
 ]
  # "contents": [
  #   {
  #     "prompt": "bank account 8775664322 routing number 2344567 dNFYiMZqQrLH35YIsEdgh2OXRXBiE7Ko1lR1nVoiJsUXdJ2T2xiT1gzL8w 6011111111111117 K sfAC3S4qB3b7tP73QBPqbHH0m9rvdcrMdmpI gbpQnQNfhmHaDRLdvrLoWTeDtx9qik0pB68UgOHbHJW7ZpU1ktK7A58icaCZWDlzL6UKswxi8t4z3 x1nK4PCsseq94a02GL7f7KkxCy7gkzfEqPWdF4UBexP1JM3BGMlTzDKb2",
  #     "response": "This is a test response"
  #   }
  # ]
})
headers = {
 'Content-Type': 'application/json',
 'Accept': 'application/json',
 'x-pan-token': API_KEY
}

response = requests.request("POST", URL, headers=headers, data=payload, timeout=TIMEOUT)
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
