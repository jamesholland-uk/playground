from panos import firewall
from panos import network

######## fw credentials ###########
api_user = "admin"
api_password = "admin"
firewall_ip = "fw.local"
fw_device = firewall.Firewall(
    firewall_ip, api_username=api_user, api_password=api_password
)

######## Pull proxy-Id from a specific VPN ########################
ipsec = network.IpsecTunnel(name="VPN-123")
fw_device.add(ipsec)
proxy = network.IpsecTunnelIpv4ProxyId.refreshall(ipsec)
for p in proxy:
    print(p.about())
