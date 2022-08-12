import sys
import pan.xapi
import xmltodict
import re
import os
from xml.etree import ElementTree


def main():

    # Define connectivity to Panorama through environment variables, for example:
    # export PANOS_HOSTNAME=my.panorama.local
    # export PANOS_API_KEY=abc123abc123
    HOSTNAME = os.environ.get("PANOS_HOSTNAME")
    USERNAME = os.environ.get("PANOS_USERNAME")
    PASSWORD = os.environ.get("PANOS_PASSWORD")

    # Hardcoded Device Group name as an example
    devicegroup = "lab-vm-series"

    # Establish connectivity to Panorama
    try:
        xapi = pan.xapi.PanXapi(
            api_username=USERNAME,
            api_password=PASSWORD,
            hostname=HOSTNAME,
            use_get=True,
        )
    except pan.xapi.PanXapiError as msg:
        print("pan.xapi.PanXapi:", msg, file=sys.stderr)
        sys.exit(1)

    # Set the xpath to represent the config we are going to output
    address_objects_xpath = (
        "/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='"
        + devicegroup
        + "']/address"
    )

    # Get candidate config's current value for the config
    xapi.get(xpath=address_objects_xpath)
    # Convert to XML Element
    root = ElementTree.fromstring(xapi.xml_document)
    print("\nFrom candidate config:")
    # Parse through the XML to print the config
    for child in root[0][0]:
        print(child.get("name"))
        for item in child:
            print("  " + item.tag, item.text)

    # Get running config's current value for the config
    xapi.show(xpath=address_objects_xpath)
    # Convert to XML Element
    root = ElementTree.fromstring(xapi.xml_document)
    print("\nFrom running config:")
    # Parse through the XML to print the config
    for child in root[0][0]:
        print(child.get("name"))
        for item in child:
            print("  " + item.tag, item.text)


if __name__ == "__main__":
    main()
