# Create DHCP reservations a CSV-based set of source data
#
# Expected CSV format:
#     MAC, IP, Description
# For example:
#     00:D0:11:00:77:10,10.10.10.1,my-hostname

# Variables
# Use *one* of these input variables to take an input file, $1 for command line arguement, of point to a file
input=$1
input="your-input-csv-file"
# The firewall management IP or FQDN
host="your-hostname"
# API key for the firewall
key="your-api-key"
# The interface on which the DHCP server is configured
interface="your ethernetX/Y interface"

# Loop
cat $input | { cat ; echo ; } | while IFS="," read -r mac ip descbad
do
    printf "\n"
    desc=$(echo $descbad | sed $'s/\r$//') # Had to replace EOL chars to get this working
    curl -ksd "key=$key&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/network/dhcp/interface/entry[@name='$interface']/server/reserved&element=<entry name='$ip'><mac>$mac</mac><description>$desc</description></entry>" https://$host/api
    printf "\n$desc, $mac, $ip\n"
done
