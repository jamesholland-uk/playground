from panos import firewall
from panos import network

######## fw credentials ###########
api_user = "admin"
api_password = "admin"
firewall_ip = "fw.local"
fw_device = firewall.Firewall(
    firewall_ip, api_username=api_user, api_password=api_password
)

##### Pull static routes from a specific vrouter ########
vr = network.VirtualRouter(name="vr-customer-1")
fw_device.add(vr)
static_routes = network.StaticRoute.refreshall(vr)
for routes in static_routes:
    print(route.about())
