# Remove a NGFW from Panorama

# Requires "xmllint": apt-get install libxml2-utils

# Variables:
# Panorama API Key
key=
# Panorama IP or hostname
panoramaip=
# Serial number of NGFW to be removed
ngfwserial=
# Device Group of NGFW
devicegroup=
# Template Stack of NGFW
templatestack=

# Remove NGFW from Device Group
printf "\nRemoving NGFW from Device Group\n"
curl -ksd "key=$key&type=config&action=delete&xpath=/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='"$devicegroup"']/devices/entry[@name='"$ngfwserial"']" https://$panoramaip/api

# Remove NGFW from Template Stack
printf "\n\nRemoving NGFW from Template Stack\n"
curl -ksd "key=$key&type=config&action=delete&xpath=/config/devices/entry[@name='localhost.localdomain']/template-stack/entry[@name='"$templatestack"']/devices/entry[@name='"$ngfwserial"']" https://$panoramaip/api

# Remove NGFW Device from Panorama
printf "\n\nRemoving NGFW Device\n"
curl -ksd "key=$key&type=config&action=delete&xpath=/config/mgt-config/devices/entry[@name='"$ngfwserial"']" https://$panoramaip/api

# Commit to Panorama
response=$(curl -skd "key=$key&type=commit&cmd=<commit-all></commit-all>" https://$panoramaip/api)

# Get commit job ID
job=$(xmllint --xpath 'string(//response/result/job)' - <<< $response)

# Get commit job status
joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$panoramaip/api)
jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)

# If job's not FINished, loop until it is...
while [ $jobstatus != "FIN" ]
do
    echo "Commit status: "$jobstatus
    sleep 5
    joboutput=$(curl -skd "key=$key&type=op&cmd=<show><jobs><id>$job</id></jobs></show>" https://$panoramaip/api)
    jobstatus=$(xmllint --xpath 'string(//response/result/job/status)' - <<< $joboutput)
done

# Final commit job status
echo "Commit status: "$jobstatus
