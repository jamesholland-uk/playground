# Create Cloud NGFW resources (managed next-generation firewall instances)
resource "cloudngfwaws_ngfw" "the_cloud_ngfw" {
  name        = "${local.projectname}-cloudngfw-instance"
  vpc_id      = local.aws_vpc_id
  account_id  = local.aws_account_id
  description = "First NGFW resource for Project ${local.projectname}"

  endpoint_mode = "ServiceManaged"
  subnet_mapping {
    subnet_id = local.cloudngfw_subnet_id
  }

  rulestack = local.rulestack_name

  tags = {
    project = "${local.projectname}"
  }
}

resource "cloudngfwaws_ngfw_log_profile" "the_logging" {
  ngfw       = cloudngfwaws_ngfw.the_cloud_ngfw.name
  account_id = cloudngfwaws_ngfw.the_cloud_ngfw.account_id

  log_destination {
    destination_type = "CloudWatchLogs"
    destination      = "PaloAltoCloudNGFW"
    log_type         = "TRAFFIC"
  }
}

# Create routes to steer traffic into Cloud NGFW (uncomment once Cloud NGFW is successfully deployed with VPC endpoint(s))
resource "aws_route" "to_dmz2" {
  route_table_id         = local.dmz1_routetable_id
  destination_cidr_block = local.dmz2_subnet_cidr_block
  vpc_endpoint_id        = cloudngfwaws_ngfw.the_cloud_ngfw.status[0].attachment[0].endpoint_id
}

resource "aws_route" "to_dmz1" {
  route_table_id         = local.dmz2_routetable_id
  destination_cidr_block = local.dmz1_subnet_cidr_block
  vpc_endpoint_id        = cloudngfwaws_ngfw.the_cloud_ngfw.status[0].attachment[0].endpoint_id
}
