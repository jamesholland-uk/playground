resource "panos_address_object" "addr1" {
  for_each = toset(["DG-Test", "hq-dg", "new-dg"])

  device_group = each.key
  name         = "addr1"
  value        = "192.168.255.1/32"
}
