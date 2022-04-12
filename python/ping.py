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

if __name__ == "__main__":
    main()
