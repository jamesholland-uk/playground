import panos
import os

from panos import firewall
from panos.objects import AddressObject, AddressGroup


def main():

    # Define connectivity to Firewall through environment variables, for example:
    # export PANOS_HOSTNAME=my.firewall.local
    # export PANOS_USERNAME=admin
    # export PANOS_PASSWORD=abc123abc123
    HOSTNAME = os.environ.get("PANOS_HOSTNAME")
    USERNAME = os.environ.get("PANOS_USERNAME")
    PASSWORD = os.environ.get("PANOS_PASSWORD")

    # Define Firewall
    fw = firewall.Firewall(HOSTNAME, USERNAME, PASSWORD)

    # Hardcoded as an example, here are new objects
    newobject1 = "internal-host1"
    newobjectvalue1 = "10.10.10.10"
    newdescription1 = "tester1"
    newobject2 = "internal-host2"
    newobjectvalue2 = "10.10.10.20"
    newdescription2 = "tester2"

    # Create address objects
    fw.add(
        AddressObject(
            name=newobject1, value=newobjectvalue1, description=newdescription1
        )
    ).create()
    fw.add(
        AddressObject(
            name=newobject2, value=newobjectvalue2, description=newdescription2
        )
    ).create()

    # Hardcoded as an example, this is the name of the new address group, with a list of member address objects
    newgroup = "internal-group"
    newgroupmembers = [newobject1, newobject2]

    # Create address group
    fw.add(AddressGroup(name=newgroup, static_value=newgroupmembers)).create()


if __name__ == "__main__":
    main()
