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

    # Hardcoded as an example, these are the names of the new objects and their values, and the rules we want to add them to
    newobject1 = "10.10.1.10"
    newobject2 = "10.10.2.10"
    devicegroup = "lab-vm-series"
    targetrule1 = "test-rule"
    targetrule2 = "admin-rule"
    targetrule3 = "test-rule-4"
    # Hardcoded as an example, this is a list of names of the objects we want to add...
    newaddressobjects = [newobject1, newobject2]
    # ...to a list of rules with these names
    targetrules = [targetrule1, targetrule2, targetrule3]
    # End of hardcoding!

    try:
        # Loop through each address object we are going to create
        for newobject in newaddressobjects:

            # Create the xpath for the address object in a Device Group
            addobjpath = (
                "/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='"
                + devicegroup
                + "']/address/entry[@name='host_"
                + newobject
                + "']"
            )

            # Create the element for address object in a Device Group
            addobjelement = "<ip-netmask>" + newobject + "</ip-netmask>"

            # Add the address to Panorama candidate configuration, using the xpath and element we just created, per address object
            xapi.set(xpath=addobjpath, element=addobjelement)

        # Loop through all the rules for which we want to add address objects
        for therule in targetrules:

            # Create xpath to be used for modifying the destination address of the rule
            destination_xpath = (
                "/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='"
                + devicegroup
                + "']/pre-rulebase/security/rules/entry[@name='"
                + therule
                + "']/destination"
            )

            # Get current destination address value for the rule
            xapi.get(xpath=destination_xpath)

            # Convert the destination address value into instance of an "ElementTree" class for our XML work
            root = ElementTree.fromstring(xapi.xml_document)

            # Check if the current destination is "any", and if so, remove it so it can be replaced with the new address objects
            if root[0][0][0].text == "any":
                for snippet in root.iter("destination"):
                    for element in snippet.findall("member"):
                        snippet.remove(element)

            # Loop through each of the new address objects created which will be added to the rule
            for address in newaddressobjects:

                # Create a new instance of "Element" class to represent XML of the new address object, first set the element name...
                newobj = ElementTree.Element("member")

                # ... then the element text value...
                newobj.text = "host_" + address

                # ...then append it into the correct place within the XML structure
                root[0][0].append(newobj)

            # Create the element text for the new address objects in the destination of the rule (removes response and result elements)
            destination_element = ElementTree.tostring(
                root[0][0], encoding="unicode", method="xml"
            )

            # Push the updated destination address to Panorama candidate configuration
            xapi.edit(xpath=destination_xpath, element=destination_element)

    except pan.xapi.PanXapiError as msg:
        print("Error:", msg, file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
