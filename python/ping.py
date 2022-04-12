import requests
import urllib3
import panos

from panos import firewall
from panos.firewall import Firewall

def main():
    fw = Firewall("vm-series-a.jamoi.xyz", "admin", "admin")

    # Test system info
    #sysinfo_response = fw.op('show system info', xml=True)
    #print(sysinfo_response)

    # Test pinging
    #ping_response = fw.op('ping host 1.1.1.1', xml=True)
    #print(ping_response)

    # Test pinging
    #urllib3.disable_warnings()
    #url = "https://vm-series-a.jamoi.xyz/api/?type=op&cmd=<cms-ping><host>1.1.1.1</host><source>192.168.0.1</source></cms-ping>"
    #auth = ("admin", "Commit123!")
    #res = requests.get(url, auth=auth, verify=False)
    #print(res.text)

if __name__ == "__main__":
    main()
