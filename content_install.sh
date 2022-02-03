# Download and install content on a NGFW

# Requires "xmllint": apt-get install libxml2-utils

# Variables:
# NGFW API Key
key=
# NGFW IP or hostname
host=



# Part 1: Check

# Check for new content
check_response=$(curl -skd "key=$key&type=op&cmd=<request><content><upgrade><check/></upgrade></content></request>" https://$host/api)



# Part 2: Download

# Start download of latest content
response=$(curl -skd "key=$key&type=op&cmd=<request><content><upgrade><download><sync-to-peer>no</sync-to-peer><force>yes</force><latest/></download></upgrade></content></request>" https://$host/api)
job=$(xmllint --xpath 'string(//response/result/job)' - <<< $response)

# Get download job ID
job=$(xmllint --xpath 'string(//response/result/job)' - <<< $response)

# Get download job status
joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)

# If job's not FINished, loop until it is...
while [ $jobstatus != "FIN" ]
do
    echo "Download status: "$jobstatus
    sleep 5
    joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
    jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)
done

# Final job status
echo "Download status: "$jobstatus



# Part 3: Install

# Start install of latest content
response=$(curl -skd "key=$key&type=op&cmd=<request><content><upgrade><install><commit>yes</commit><sync-to-peer>no</sync-to-peer><disable-new-content>yes</disable-new-content><force>yes</force><skip-content-validity-check>yes</skip-content-validity-check><version>latest</version></install></upgrade></content></request>" https://$host/api)
job=$(xmllint --xpath 'string(//response/result/job)' - <<< $response)

# Get install job ID
job=$(xmllint --xpath 'string(//response/result/job)' - <<< $response)

# Get install job status
joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)

# If job's not FINished, loop until it is...
while [ $jobstatus != "FIN" ]
do
    echo "Install status: "$jobstatus
    sleep 5
    joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$host/api)
    jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)
done

# Final job status
echo "Install status: "$jobstatus
