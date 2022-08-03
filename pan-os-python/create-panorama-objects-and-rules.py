import panos
import os

from panos import policies, objects, panorama
from panos.panorama import Panorama, DeviceGroup
from panos.objects import AddressObject, AddressGroup
from panos.policies import PostRulebase, PreRulebase, SecurityRule


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

    # Define Device Group
    dg = DeviceGroup("lab-vm-series")
    panorama.add(dg)

    # Define Rulebases
    prerulebase = PreRulebase()
    dg.add(prerulebase)
    postrulebase = PostRulebase()
    dg.add(postrulebase)

    # Get current rule counts
    prerules = SecurityRule.refreshall(prerulebase)
    print("Current Pre Rules count: {0}".format(len(prerules)))
    postrules = SecurityRule.refreshall(postrulebase)
    print("Current Post Rules count: {0}".format(len(postrules)))

    # Add address objects
    internalhost1 = AddressObject(name="internal-host1", value="10.10.1.10")
    dg.add(internalhost1)
    internalhost1.create()
    internalhost2 = AddressObject(name="internal-host2", value="10.10.2.10")
    dg.add(internalhost2)
    internalhost2.create()

    # Add an address group
    internalhostgroup = AddressGroup(
        name="internal-hosts", static_value=["internal-host1", "internal-host2"]
    )
    dg.add(internalhostgroup)
    internalhostgroup.create()

    # Add a rule to Pre Rules
    prerule = SecurityRule(
        name="new pre rule",
        fromzone=["internal"],
        tozone=["internet"],
        source=["internal-hosts"],
        destination=["any"],
        application=["web-browsing"],
        action="allow",
    )
    prerulebase.add(prerule)
    dg.add(prerulebase)
    prerulebase.create()

    # Add a rule to Post Rules
    postrule = SecurityRule(
        name="new post rule",
        fromzone=["internal"],
        tozone=["internet"],
        source=["internal-hosts"],
        destination=["any"],
        application=["ssh"],
        action="allow",
    )
    postrulebase.add(postrule)
    dg.add(postrulebase)
    postrulebase.create()

    # Get new current rule counts
    prerules = SecurityRule.refreshall(prerulebase)
    print("Current Pre Rules count: {0}".format(len(prerules)))
    postrules = SecurityRule.refreshall(postrulebase)
    print("Current Post Rules count: {0}".format(len(postrules)))


if __name__ == "__main__":
    main()
