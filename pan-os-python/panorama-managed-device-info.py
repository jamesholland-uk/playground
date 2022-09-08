import panos
import os

from panos import panorama
from panos.panorama import Panorama
from xml.etree import ElementTree


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

    # Get list of managed devices, filtering on only those that are connected, and not including the Device Group context for simplicity
    devices = panorama.refresh_devices(only_connected=True, include_device_groups=False)

    print("-------------------------------")
    for device in devices:
        print("Mgmt IP:     " + device.children[0].ip_address)
        print("Hostname:    " + device.children[0].hostname)
        print("Hostname:    " + device.serial)
        if device.is_active():
            print("I AM ACTIVE")
        print("-------------------------------")

    connDev = panorama.op(cmd="show devices connected", xml=True)
    root = ElementTree.fromstring(connDev)
    for device in root[0][0]:
        print(device.attrib)
        print(device.find("ha").find("state").text)

    print()


if __name__ == "__main__":
    main()
