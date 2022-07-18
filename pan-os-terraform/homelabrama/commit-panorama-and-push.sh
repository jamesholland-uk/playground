#!/bin/bash

# Commit to Panorama and push to Device Group

# Variables
host="51.104.35.72"
key="LUFRPT1LN2tYbnZpbGFRcXY0UEZ4TVVEV0JVTGh4eWs9TWRRa3lLMTRaSnBtUEZhVzZrVXVLYzF3dHlLOWZmY0FyeUZMREkrWFd3RE1xSktmYWZHdHZ4eUw1ZHZqNWZ0Yw=="
templatestack="test-tpl-stack"

# Commit to Panorama
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

# Push to DG
response=$(curl -skd "key=$key&type=commit&action=all&cmd=<commit-all><template-stack><name>$templatestack</name></template-stack></commit-all>" https://$host/api)

# Get push job ID
job=$(xmllint --xpath 'string(//response/result/job)' - <<< $response)

# Get push job status
joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)

# If job's not FINished, loop until it is...
while [ $jobstatus != "FIN" ]
do
    echo "Push status: "$jobstatus
    sleep 5
    joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
    jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)
done

# Final push job status
echo "Push status: "$jobstatus
