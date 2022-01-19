# Remove a NGFW from Panorama

# Variables:
# Panorama API Key
key=LUFRPT1ta21GZlZQVXptOGR0YXF2MFppOEtRNjNEbFk9ck9vc2tGcmlHV0tDbWRFa2cxcGUxSFhBN1JvK2tlMXFZK3dqZHp2UDJvdlZnaFRSaWs5VThKMHJJYXJ0dllUcQ==
# Panorama IP or hostname
panoramaip=rama.jamoi.xyz
# Serial number of NGFW to be removed
ngfwserial=123423423423423423
# Device Group of NGFW
devicegroup=new-dg
# Template Stack of NGFW
templatestack=new-tmplstack

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
