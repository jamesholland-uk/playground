from panos import panorama
from panos.panorama import Panorama, DeviceGroup
from panos.policies import PreRulebase, PostRulebase, SecurityRule

######## Panorama connectivity ###########
api_user = "admin"
api_password = "admin"
host = "panorama.local"
pano = Panorama(host, api_user, api_password)

##### Pull security rules from Shared ########
pre_rulebase = pano.add(PreRulebase())
pre_rules = SecurityRule.refreshall(pre_rulebase)
print('\nShared: Pre-rules')
for rule in pre_rules:
    print(rule.name)

post_rulebase = pano.add(PostRulebase())
post_rules = SecurityRule.refreshall(post_rulebase)
print('\nShared: Post-rules')
for rule in post_rules:
    print(rule.name)

##### Pull security rules from a Device Group ########
devicegroup_name = "lab-vm-series"

device_group = panorama.DeviceGroup(devicegroup_name)
pano.add(device_group)
device_group.refresh()

pre_rulebase = device_group.add(PreRulebase())
pre_rules = SecurityRule.refreshall(pre_rulebase)
print('\n"' + devicegroup_name + '" Device Group: Pre-rules')
for rule in pre_rules:
    print(rule.name)

post_rulebase = device_group.add(PostRulebase())
post_rules = SecurityRule.refreshall(post_rulebase)
print('\n"' + devicegroup_name + '" Device Group: Post-rules')
for rule in post_rules:
    print(rule.name)
