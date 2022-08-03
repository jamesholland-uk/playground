import panos
import os

from panos import panorama
from panos.panorama import Panorama


def main():

    # Define connectivity to Panorama through environment variables, for example:
    # export PANOS_HOSTNAME=my.panorama.local
    # export PANOS_USERNAME=admin
    # export PANOS_PASSWORD=abc123abc123
    HOSTNAME = os.environ.get("PANOS_HOSTNAME")
    USERNAME = os.environ.get("PANOS_USERNAME")
    PASSWORD = os.environ.get("PANOS_PASSWORD")

    # Define Panorama
    panorama = Panorama(HOSTNAME, USERNAME, PASSWORD)

    # Test system info
    sysinfo_response = panorama.op("show system info", xml=True)
    print(sysinfo_response)


if __name__ == "__main__":
    main()
