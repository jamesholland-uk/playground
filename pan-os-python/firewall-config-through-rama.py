# Just a snippet, does not constitute a full script

# Instantiate a Firewall with serial
fw = firewall.Firewall(serial="1234567890")
# Instantiate a Panorama with hostname and credentials
pano = panorama.Panorama("10.0.0.5", "admin", "mypassword")
# Add the Firewall as a child of Panorama
pano.add(fw)
# Change to Firewall via Panorama
fw.add(objects.AddressObject("Server", "2.2.2.2")).create()
# Change to Panorama directly
pano.add(panorama.DeviceGroup("DG_A")).create()
