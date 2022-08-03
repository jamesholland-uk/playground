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

    # Define Panorama
    panorama = Panorama(HOSTNAME, USERNAME, PASSWORD)

    # Hardcoded as an example, this is the name of the new object, it's value, and the name of the rule which will receive the new object
    newobject = "internal-host1"
    newobjectvalue = "10.10.1.10"
    targetrule = "test-rule"

    # Define Device Group
    dg = DeviceGroup("lab-vm-series")
    panorama.add(dg)

    # Define Rulebase
    prerulebase = PreRulebase()
    dg.add(prerulebase)

    # Create Address Object and add to Device Group, then use create() to push to Panorama candidate configuration
    internalhost1 = AddressObject(name=newobject, value=newobjectvalue)
    dg.add(internalhost1)
    internalhost1.create()

    # Create "prerules", a list of instances of the SecurityRule class, from the prerulebase, gathered from live Panorama using refreshall()
    prerules = SecurityRule.refreshall(prerulebase)

    # Loop through the rules in the rulebase, find the target rule, and add the object to the list of existing objects
    for firewallrule in prerules:
        if firewallrule.name == targetrule:
            #
            #
            #
            # Needs to check for "any" in current destaintion
            #
            #
            #
            firewallrule.destination.append(newobject)
            firewallrule.create()


if __name__ == "__main__":
    main()
