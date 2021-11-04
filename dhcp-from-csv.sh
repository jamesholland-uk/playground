# Create DHCP reservations a CSV-based set of source data
#
# Expected CSV format:
#     MAC, IP, Description
# For example:
#     00:D0:11:00:77:10,10.10.10.1,my-hostname

# Variables
input=$1
input="your-input-csv-file"
host="your-hostname"
key="your-api-key"
interface="your ethernetX/Y interface"

# Loop
cat $input | { cat ; echo ; } | while IFS="," read -r mac ip descbad
do
    printf "\n"
    desc=$(echo $descbad | sed $'s/\r$//') # Had to replace EOL chars to get this working
    curl -ksd "key=$key&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/network/dhcp/interface/entry[@name='$interface']/server/reserved&element=<entry name='$ip'><mac>$mac</mac><description>$desc</description></entry>" https://$host/api
    printf "\n$desc, $mac, $ip\n"
done
