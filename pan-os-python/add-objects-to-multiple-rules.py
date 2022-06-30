import panos
import os

from panos import policies, objects, panorama
from panos.panorama import Panorama, DeviceGroup
from panos.objects import AddressObject
from panos.policies import PreRulebase, SecurityRule


def main():

    # Define connectivity to Panorama through environment variables, for example:
    # export PANOS_HOSTNAME=my.panorama.local
    # export PANOS_USERNAME=admin
    # export PANOS_PASSWORD=abc123abc123
    HOSTNAME = os.environ.get("PANOS_HOSTNAME")
    USERNAME = os.environ.get("PANOS_USERNAME")
    PASSWORD = os.environ.get("PANOS_PASSWORD")

    # Establish connectivity to Panorama
    panorama = Panorama(HOSTNAME, USERNAME, PASSWORD)

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

    # Define Device Group
    dg = DeviceGroup(devicegroup)
    panorama.add(dg)

    # Define Rulebase
    prerulebase = PreRulebase()
    dg.add(prerulebase)

    # Create Address Objects and add to Device Group, then use create() to push to Panorama candidate configuration
    for newaddress in newaddressobjects:
        newobject = AddressObject(name="host_" + newaddress, value=newaddress)
        dg.add(newobject)
        newobject.create()

    # Create "prerules", a list of instances of the SecurityRule class, from the prerulebase, gathered from live Panorama using refreshall()
    prerules = SecurityRule.refreshall(prerulebase)

    # Loop through the list of rules in the prerulebase...
    for firewallrule in prerules:
        # ... and for each of our target rules...
        for targetrule in targetrules:
            # ...when we find a target rule...
            if firewallrule.name == targetrule:
                # ...loop through each object we are wanting to add...
                for newdestination in newaddressobjects:
                    # ...and if the current destination is "any", replace "any" with the new object
                    if firewallrule.destination[0] == "any":
                        firewallrule.destination[0] = "host_" + newdestination
                    # ...otherwise, add the new object to the existing (non-empty) destination
                    else:
                        firewallrule.destination.append("host_" + newdestination)
                # We have added all new objects, and have modified the target rule, so use apply() to push it to Panorama candidate configuration
                firewallrule.apply()


if __name__ == "__main__":
    main()
