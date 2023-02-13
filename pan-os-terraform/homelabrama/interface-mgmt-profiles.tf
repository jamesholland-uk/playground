resource "panos_management_profile" "ping" {
  name                       = "allow-ping-mgmt"
  ping                       = true
  userid_syslog_listener_udp = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_management_profile" "admin" {
  name                       = "allow-admin"
  ping                       = true
  ssh                        = true
  https                      = true
  userid_syslog_listener_udp = null

  lifecycle {
    create_before_destroy = true
  }
}
