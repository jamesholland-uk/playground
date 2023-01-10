# Not working at this time

import os
from netmiko import ConnectHandler

print("Connecting...")

virtual_palo = {
    "device_type": "paloalto_panos",
    "host": os.environ.get("PANOS_HOSTNAME"),
    "username": os.environ.get("PANOS_USERNAME"),
    "password": os.environ.get("PANOS_PASSWORD"),
    "session_log": "output.txt",
}

net_connect = ConnectHandler(**virtual_palo)

output = net_connect.send_command("show system info")
print(output)
print("Done")
