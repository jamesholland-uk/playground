#!/bin/bash

#
# A (not very good, very untested) script to check usage of multi-use VM-Series auth codes, and alert via email (Mailgun) if a threshold is breached
# Use at your own peril
#

#
# Usage: check-vm-auth-code.sh <licensing-api-key> <auth-code> <tolerance> <API key for Mailgun> <email address for alerting>
# Example: check-vm-auth-code.sh 7eccae9333361f3cbd798ee1e8c70bad9dfe C12345 75 key-1234567890 test@test.local
#

apikey=$1
authcode=$2
tolerance=$3
emailapikey=$4
emailaddress=$5


# Initialise logging
logfile="check-vm-auth-code-log.txt"
exec &>> $logfile
now="$(date)"
printf "\n\n\n\n\n\n*** Checking VM auth code on `date` ***\n\n" >> $logfile


# Talk to the licensing API service, break up into multi-line reponse delimite by comma
apiresponse=$(curl -s -H "apikey:$apikey" --data-urlencode authcode=$authcode  https://api.paloaltonetworks.com/api/license/get | tr "," "\n")
printf "Used:$apiresponse\n" >> $logfile

# Error checking of the response from API service
if [[ $apiresponse == *"Invalid"* ]]
    then
        # Error condition, emtpy string, likely licensing API key got regenerated, send an email alert
        printf "API response had errors\n" >> $logfile
        msg="Error accessing Licensing API (used count returned an empty string)."
        curl -s --user 'api:'"$emailapikey"'' https://api.mailgun.net/v3/demo.panw.co.uk/messages -F from='Palo Alto Networks <demo@demo.panw.co.uk>' -F to=$emailaddress -F subject='LICENSING API' -F html=' '"$msg"' '
    else
        # Response was ok
        printf "API response ok\n" >> $logfile

        # Get the used number of VMs from the auth code
        used=$(printf "$apiresponse" | grep UsedCount | cut -d ":" -f 2)
        printf "Used:$used\n" >> $logfile

        # Get the available number of VMs from the auth code
        available=$(printf "$apiresponse" | grep TotalVMCount | cut -d ":" -f 2)
        printf "Available:$available\n" >> $logfile

        # Multiply first factor by 100 to get around bash's lack of floating point arithmetic, then calculate percentage utilisation
        used="$(($used * 100))"
        utilisation="$((used / available))"
        printf "Util:$utilisation\n" >> $logfile
        printf "Tolerance:$tolerance\n" >> $logfile

        # Check if utilisation is greater then the tolerance
        if [ "$utilisation" -ge "$tolerance" ]
            then
                # If utilisation is greater then the tolerance, send an email alert
                printf "Utilisation greater than tolerance, sending email\n" >> $logfile
                msg="Utilisation of auth code $authcode is $utilisation per cent, which is higher than tolerance of $tolerance per cent."
                curl -s --user 'api:'"$emailapikey"'' https://api.mailgun.net/v3/demo.panw.co.uk/messages -F from='Palo Alto Networks <demo@demo.panw.co.uk>' -F to=$emailaddress -F subject='LICENSING API' -F html=' '"$msg"' '
            else
                # Utilisation is less then the tolerance
                printf "Utilisation less than tolerance, no email needed\n" >> $logfile
        fi
fi
