# Create a Rulestack
resource "cloudngfwaws_rulestack" "the_rulestack" {
  name        = "${local.projectname}-rulestack"
  scope       = "Local"
  account_id  = local.aws_account_id
  description = "Made with Terraform for ${local.projectname} Project"

  profile_config {
    anti_spyware  = "BestPractice"
    anti_virus    = "BestPractice"
    vulnerability = "BestPractice"
    file_blocking = "BestPractice"
    url_filtering = "BestPractice"
  }

  tags = {
    project = "${local.projectname}"
  }
}

# Create prefix lists for the EC2 hosts in AWS
resource "cloudngfwaws_prefix_list" "host1" {
  rulestack   = cloudngfwaws_rulestack.the_rulestack.name
  name        = "${local.projectname}-host1"
  description = "Made with Terraform for ${local.projectname} Project"
  prefix_list = [
    local.host1_private_ip
  ]
  audit_comment = "Initial config"
}

resource "cloudngfwaws_prefix_list" "host2" {
  rulestack   = cloudngfwaws_rulestack.the_rulestack.name
  name        = "${local.projectname}-host2"
  description = "Made with Terraform for ${local.projectname} Project"
  prefix_list = [
    local.host2_private_ip
  ]
  audit_comment = "Initial config"
}

# Create security rules to allow hosts to ping each other
resource "cloudngfwaws_security_rule" "rule1" {
  rulestack   = cloudngfwaws_rulestack.the_rulestack.name
  rule_list   = "LocalRule"
  priority    = 101
  name        = "Rule1"
  description = "Made with Terraform for ${local.projectname} Project"
  source {
    prefix_lists = [cloudngfwaws_prefix_list.host1.name]
  }
  destination {
    prefix_lists = [cloudngfwaws_prefix_list.host2.name]
  }
  applications = ["ping"]
  protocol     = "application-default"
  category {}
  action        = "Allow"
  logging       = true
  audit_comment = "Initial config"

  tags = {
    project = "${local.projectname}"
  }

  enabled = true
}

resource "cloudngfwaws_security_rule" "rule2" {
  rulestack   = cloudngfwaws_rulestack.the_rulestack.name
  rule_list   = "LocalRule"
  priority    = 102
  name        = "Rule2"
  description = "Made with Terraform for ${local.projectname} Project"
  source {
    prefix_lists = [cloudngfwaws_prefix_list.host2.name]
  }
  destination {
    prefix_lists = [cloudngfwaws_prefix_list.host1.name]
  }
  applications = ["ping"]
  protocol     = "application-default"
  category {}
  action        = "Allow"
  logging       = true
  audit_comment = "Initial config"

  tags = {
    project = "${local.projectname}"
  }

  enabled = true
}
