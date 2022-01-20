# Commit to a NGFW

# Requires "xmllint": apt-get install libxml2-utils

# Variables:
# NGFW API Key
key=
# NGFW IP or hostname
host=


# Start commit
response=$(curl -skd "key=$key&type=commit&cmd=<commit-all></commit-all>" https://$host/api)

# Get commit job ID
job=$(xmllint --xpath 'string(//response/result/job)' - <<< $response)

# Get commit job status
joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)

# If job's not FINished, loop until it is...
while [ $jobstatus != "FIN" ]
do
    echo "Commit status: "$jobstatus
    sleep 5
    joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
    jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)
done

# Final commit job status
echo "Commit status: "$jobstatus
