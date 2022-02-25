#
# This has turned mostly into a testing ground whilst I've been developing PAN-OS Terraform resource checks for Checkov! :-)
#
#
#
# # The DSRI setting can be applied in either the panos_security_policy resource or the panos_security_rule_group resource.
# # Both resource types are covered by this check.

# # DSRI is set to true, disabling server-to-client inspection, which is a fail
# resource "panos_security_policy" "fail1" {
#     rule {
#         name = "my-bad-rule-fail1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = true
#     }
# }

# # DSRI is set to true, disabling server-to-client inspection, which is a fail
# resource "panos_security_rule_group" "fail2" {
#     rule {
#         name = "my-bad-rule-fail2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = true
#     }
# }

# # DSRI is set to true in the second rule, disabling server-to-client inspection, which is a fail
# resource "panos_security_policy" "fail3" {
#     rule {
#         name = "my-bad-fail3-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
#     rule {
#         name = "my-bad-fail3-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = true
#     }
# }

# # DSRI is set to true in the second rule, disabling server-to-client inspection, which is a fail
# resource "panos_security_rule_group" "fail4" {
#     rule {
#         name = "my-bad-fail4-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
#     rule {
#         name = "my-bad-fail4-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = true
#     }
# }

# # DSRI is set to false, ensuring server-to-client inspection is enabled, which is a pass
# resource "panos_security_policy" "pass1" {
#     rule {
#         name = "my-good-rule-pass1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
# }

# # DSRI is set to false, ensuring server-to-client inspection is enabled, which is a pass
# resource "panos_security_rule_group" "pass2" {
#     rule {
#         name = "my-good-rule-pass2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
# }

# # Not explicitly setting the DSRI attribute when creating a rule leads to the default setting of false, which ensures server-to-client inspection is enabled, which is a pass
# resource "panos_security_policy" "pass3" {
#     rule {
#         name = "my-good-rule-pass3"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Not explicitly setting the DSRI attribute when creating a rule leads to the default setting of false, which ensures server-to-client inspection is enabled, which is a pass
# resource "panos_security_rule_group" "pass4" {
#     rule {
#         name = "my-good-rule-pass4"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # DSRI is set to false in both rules, ensuring server-to-client inspection is enabled, which is a pass
# resource "panos_security_policy" "pass5" {
#     rule {
#         name = "my-good-pass5-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
#     rule {
#         name = "my-good-pass5-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
# }

# # DSRI is set to false in both rules, ensuring server-to-client inspection is enabled, which is a pass
# resource "panos_security_rule_group" "pass6" {
#     rule {
#         name = "my-good-pass6-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
#     rule {
#         name = "my-good-pass6-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         disable_server_response_inspection = false
#     }
# }




# # The "applications" attribute can be defined in either the panos_security_policy resource or the panos_security_rule_group resource.
# # Both resource types are covered by this check.

# # Note: Not explicitly setting the applications attribute when creating a rule is not valid, the applications attribute is mandatory and will fail Terraform validation at plan stage, so this is not covered in test cases

# # Note: Setting an applications list item of "any" alongside other applications is not valid, "any" must be used on it's own, and if used in a list alongside other application names and will fail Terraform validation at apply stage, so this is not covered in test cases

# # Application is set to any, which is a fail as it is overly permissive
# resource "panos_security_policy" "fail1app" {
#     rule {
#         name = "my-bad-rule-fail1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to any, which is a fail as it is overly permissive
# resource "panos_security_rule_group" "fail2app" {
#     rule {
#         name = "my-bad-rule-fail2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to non-any in the first rule, but any in the second rule, which is a fail as it is overly permissive
# resource "panos_security_policy" "fail3app" {
#     rule {
#         name = "my-bad-fail3-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
#     rule {
#         name = "my-bad-fail3-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to non-any in the first rule, but any in the second rule, which is a fail as it is overly permissive
# resource "panos_security_rule_group" "fail4app" {
#     rule {
#         name = "my-bad-fail4-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
#     rule {
#         name = "my-bad-fail4-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["any"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to a non-any value, which is a pass
# resource "panos_security_policy" "pass1" {
#     rule {
#         name = "my-good-rule-pass1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to a non-any value, which is a pass
# resource "panos_security_rule_group" "pass2" {
#     rule {
#         name = "my-good-rule-pass2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to a non-any value in both rules, which is a pass
# resource "panos_security_policy" "pass3" {
#     rule {
#         name = "my-good-pass3-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass3-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to a non-any value in both rules, which is a pass
# resource "panos_security_rule_group" "pass4" {
#     rule {
#         name = "my-good-pass4-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass4-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to multiple non-any values, which is a pass
# resource "panos_security_policy" "pass5" {
#     rule {
#         name = "my-good-rule-pass5"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Application is set to multiple non-any values, which is a pass
# resource "panos_security_rule_group" "pass6" {
#     rule {
#         name = "my-good-rule-pass6"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }


# # The "services" attribute can be defined in either the panos_security_policy resource or the panos_security_rule_group resource.
# # Both resource types are covered by this check.

# # Note: Not explicitly setting the services attribute when creating a rule is not valid, the services attribute is mandatory and will fail Terraform validation at plan stage, so this is not covered in test cases

# # Note: Setting an services list item of "any" alongside other services is not valid, "any" must be used on it's own, and if used in a list alongside other services names and will fail Terraform validation at apply stage, so this is not covered in test cases

# # Services is set to any, which is a fail as it is overly permissive
# resource "panos_security_policy" "fail1" {
#     rule {
#         name = "my-bad-rule-fail1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Services is set to any, which is a fail as it is overly permissive
# resource "panos_security_rule_group" "fail2" {
#     rule {
#         name = "my-bad-rule-fail2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Services is set to non-any in the first rule, but any in the second rule, which is a fail as it is overly permissive
# resource "panos_security_policy" "fail3" {
#     rule {
#         name = "my-bad-fail3-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-bad-fail3-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Services is set to non-any in the first rule, but any in the second rule, which is a fail as it is overly permissive
# resource "panos_security_rule_group" "fail4" {
#     rule {
#         name = "my-bad-fail4-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-bad-fail4-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Services is set to a non-any value, which is a pass
# resource "panos_security_policy" "pass1" {
#     rule {
#         name = "my-good-rule-pass1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # Services is set to a non-any value, which is a pass
# resource "panos_security_rule_group" "pass2" {
#     rule {
#         name = "my-good-rule-pass2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # Services is set to a non-any value in both rules, which is a pass
# resource "panos_security_policy" "pass3" {
#     rule {
#         name = "my-good-pass3-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass3-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # Services is set to a non-any value in both rules, which is a pass
# resource "panos_security_rule_group" "pass4" {
#     rule {
#         name = "my-good-pass4-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass4-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # Services is set to multiple non-any values, which is a pass
# resource "panos_security_policy" "pass5" {
#     rule {
#         name = "my-good-rule-pass5"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }

# # Services is set to multiple non-any values, which is a pass
# resource "panos_security_rule_group" "pass6" {
#     rule {
#         name = "my-good-rule-pass6"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }

# # The "source_addresses" and "destination_addresses" attributes can be defined in either the panos_security_policy resource or the panos_security_rule_group resource.
# # Both resource types are covered by this check.

# # Note: Not explicitly setting the "source_addresses" and "destination_addresses" attributes when creating a rule is not valid, the "source_addresses" and "destination_addresses" attributes are mandatory and will fail Terraform validation at plan stage, so this is not covered in test cases

# # Note: Setting a "source_addresses" or "destination_addresses" list item of "any" alongside other items is not technically valid PAN-OS configuration, but the provider and the OS accept it (even though it can't be configured this way in the GUI). However, because it is possible to create this type of configuration in Terraform without error, there are test cases for it

# # "source_addresses" and "destination_addresses" are both set to any, which is a fail as it is overly permissive
# resource "panos_security_policy" "fail1" {
#     rule {
#         name = "my-bad-rule-fail1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any, which is a fail as it is overly permissive
# resource "panos_security_rule_group" "fail2" {
#     rule {
#         name = "my-bad-rule-fail2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any in the second rule, which is a fail as it is overly permissive
# resource "panos_security_policy" "fail3" {
#     rule {
#         name = "my-bad-fail3-rule1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-bad-fail3-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any in the second rule, which is a fail as it is overly permissive
# resource "panos_security_rule_group" "fail4" {
#     rule {
#         name = "my-bad-fail4-rule1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-bad-fail4-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any, even though the source_address has other list items after any, which is a fail as it is overly permissive 
# resource "panos_security_policy" "fail5" {
#     rule {
#         name = "my-bad-rule-fail5"
#         source_zones = ["any"]
#         source_addresses = ["any","10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any, even though the source_address has other list items before any, which is a fail as it is overly permissive 
# resource "panos_security_rule_group" "fail6" {
#     rule {
#         name = "my-bad-rule-fail6"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32","any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any, even though the destination_addresses has other list items after any, which is a fail as it is overly permissive 
# resource "panos_security_policy" "fail7" {
#     rule {
#         name = "my-bad-rule-fail7"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any","10.10.10.10/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any, even though the destination_address has other list items before any, which is a fail as it is overly permissive 
# resource "panos_security_rule_group" "fail8" {
#     rule {
#         name = "my-bad-rule-fail8"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["10.10.10.10/32","any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any, even though both source_address and destination_address have other list items after any, which is a fail as it is overly permissive 
# resource "panos_security_policy" "fail9" {
#     rule {
#         name = "my-bad-rule-fail9"
#         source_zones = ["any"]
#         source_addresses = ["any","10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any","10.10.10.10/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are both set to any, even though both source_address and destination_address have other list items after any, which is a fail as it is overly permissive 
# resource "panos_security_rule_group" "fail10" {
#     rule {
#         name = "my-bad-rule-fail10"
#         source_zones = ["any"]
#         source_addresses = ["any","10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any","10.10.10.10/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["service-http","service-https"]
#         action = "allow"
#     }
# }



# # "source_addresses" is set to a non-any value, which is a pass ("destination_addresses" set to any is valid for traffic destined for the Internet)
# resource "panos_security_policy" "pass1" {
#     rule {
#         name = "my-good-rule-pass1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" is set to a non-any value, which is a pass ("destination_addresses" set to any is valid for traffic destined for the Internet)
# resource "panos_security_rule_group" "pass2" {
#     rule {
#         name = "my-good-rule-pass2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "destination_addresses" is set to a non-any value, which is a pass ("source_addresses" set to any is valid for hosting Internet-facing workloads)
# resource "panos_security_policy" "pass3" {
#     rule {
#         name = "my-good-rule-pass3"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "destination_addresses" is set to a non-any value, which is a pass ("source_addresses" set to any is valid for hosting Internet-facing workloads)
# resource "panos_security_rule_group" "pass4" {
#     rule {
#         name = "my-good-rule-pass4"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "destination_addresses" is set to a non-any value in both rules, which is a pass ("source_addresses" set to any is valid for hosting Internet-facing workloads)
# resource "panos_security_policy" "pass5" {
#     rule {
#         name = "my-good-pass5-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass5-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.4.4/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "destination_addresses" is set to a non-any value in both rules, which is a pass ("source_addresses" set to any is valid for hosting Internet-facing workloads)
# resource "panos_security_rule_group" "pass6" {
#     rule {
#         name = "my-good-pass6-rule1"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass5-rule2"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.4.4/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" is set to a non-any value in both rules, which is a pass ("destination_addresses" set to any is valid for traffic destined for the Internet)
# resource "panos_security_policy" "pass7" {
#     rule {
#         name = "my-good-pass7-rule1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass7-rule2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" is set to a non-any value in both rules, which is a pass ("destination_addresses" set to any is valid for traffic destined for the Internet)
# resource "panos_security_rule_group" "pass8" {
#     rule {
#         name = "my-good-pass8-rule1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
#     rule {
#         name = "my-good-pass8-rule2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "destination_addresses" is set to multiple non-any values, which is a pass ("source_addresses" set to any is valid for hosting Internet-facing workloads)
# resource "panos_security_policy" "pass9" {
#     rule {
#         name = "my-good-rule-pass9"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32", "8.8.4.4/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "destination_addresses" is set to multiple non-any values, which is a pass ("source_addresses" set to any is valid for hosting Internet-facing workloads)
# resource "panos_security_rule_group" "pass10" {
#     rule {
#         name = "my-good-rule-pass10"
#         source_zones = ["any"]
#         source_addresses = ["any"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32", "8.8.4.4/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" is set to multiple non-any values, which is a pass ("destination_addresses" set to any is valid for traffic destined for the Internet)
# resource "panos_security_policy" "pass11" {
#     rule {
#         name = "my-good-rule-pass11"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32","10.10.10.11/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" is set to multiple non-any values, which is a pass ("destination_addresses" set to any is valid for traffic destined for the Internet)
# resource "panos_security_rule_group" "pass12" {
#     rule {
#         name = "my-good-rule-pass12"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32","10.10.10.11/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["any"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are set to non-any values, which is a pass
# resource "panos_security_policy" "pass13" {
#     rule {
#         name = "my-good-rule-pass13"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }

# # "source_addresses" and "destination_addresses" are set to non-any values, which is a pass
# resource "panos_security_rule_group" "pass14" {
#     rule {
#         name = "my-good-rule-pass14"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#     }
# }



# # The description be used in either the panos_security_policy resource or the panos_security_rule_group resource.
# # Both resource types are covered by this check.

# # Fails

# # Security rules should should have a description populated to communicate the purpose for the rule, absence of the description attribute is therefore a fail
# resource "panos_security_policy" "fail1" {
#     rule {
#         name = "my-bad-rule-fail1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, absence of the description attribute is therefore a fail
# resource "panos_security_rule_group" "fail2" {
#     rule {
#         name = "my-bad-rule-fail2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, any empty description attribute is therefore a fail
# resource "panos_security_policy" "fail3" {
#     rule {
#         name = "my-bad-rule-fail3"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = ""
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, an empty description attribute is therefore a fail
# resource "panos_security_rule_group" "fail4" {
#     rule {
#         name = "my-bad-rule-fail4"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = ""
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, any empty description attribute is therefore a fail (2nd rule)
# resource "panos_security_policy" "fail5" {
#     rule {
#         name = "my-good-rule-fail5"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
#     rule {
#         name = "my-bad-rule-fail5"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = ""
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, an empty description attribute is therefore a fail (2nd rule)
# resource "panos_security_rule_group" "fail6" {
#     rule {
#         name = "my-good-rule-fail6"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
#     rule {
#         name = "my-bad-rule-fail6"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = ""
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, absence of the description attribute is therefore a fail (2nd rule)
# resource "panos_security_policy" "fail7" {
#     rule {
#         name = "my-good-rule-fail7"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
#     rule {
#         name = "my-bad-rule-fail7"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, absence of the description attribute is therefore a fail (2nd rule)
# resource "panos_security_rule_group" "fail8" {
#     rule {
#         name = "my-good-rule-fail8"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
#     rule {
#         name = "my-bad-rule-fail8"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#     }
# }


# # Passes

# # Security rules should should have a description populated to communicate the purpose for the rule
# resource "panos_security_policy" "pass1" {
#     rule {
#         name = "my-good-rule-pass1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule
# resource "panos_security_rule_group" "pass2" {
#     rule {
#         name = "my-good-rule-pass2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, test block with 2 passing rules 
# resource "panos_security_policy" "pass3" {
#     rule {
#         name = "my-good-rule-pass3-1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
#     rule {
#         name = "my-good-rule-pass3-2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
# }

# # Security rules should should have a description populated to communicate the purpose for the rule, test block with 2 passing rules
# resource "panos_security_rule_group" "pass4" {
#     rule {
#         name = "my-good-rule-pass4-1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
#     rule {
#         name = "my-good-rule-pass4-2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
# }


# # The Log Forwarding Profile attribute "log_setting" be used in either the panos_security_policy resource or the panos_security_rule_group resource.
# # Both resource types are covered by this check.

# # Fails

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore absence of the log_setting attribute is therefore a fail
# resource "panos_security_policy" "fail1" {
#     rule {
#         name = "my-bad-rule-fail1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore absence of the log_setting attribute is therefore a fail
# resource "panos_security_rule_group" "fail2" {
#     rule {
#         name = "my-bad-rule-fail2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore any empty log_setting attribute is a fail
# resource "panos_security_policy" "fail3" {
#     rule {
#         name = "my-bad-rule-fail3"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = ""
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore any empty log_setting attribute is a fail
# resource "panos_security_rule_group" "fail4" {
#     rule {
#         name = "my-bad-rule-fail4"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = ""
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore any empty log_setting attribute is a fail (2nd rule)
# resource "panos_security_policy" "fail5" {
#     rule {
#         name = "my-good-rule-fail5"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-bad-rule-fail5"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = ""
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore any empty log_setting attribute is a fail (2nd rule)
# resource "panos_security_rule_group" "fail6" {
#     rule {
#         name = "my-good-rule-fail6"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-bad-rule-fail6"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = ""
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore absence of the log_setting attribute is therefore a fail (2nd rule)
# resource "panos_security_policy" "fail7" {
#     rule {
#         name = "my-good-rule-fail7"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-bad-rule-fail7"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore absence of the log_setting attribute is therefore a fail (2nd rule)
# resource "panos_security_rule_group" "fail8" {
#     rule {
#         name = "my-good-rule-fail8"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-bad-rule-fail8"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."

#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore any empty log_setting attribute is a fail (even strings of spaces) 
# resource "panos_security_policy" "fail9" {
#     rule {
#         name = "my-bad-rule-fail9"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "  "
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, therefore any empty log_setting attribute is a fail (even strings of spaces)
# resource "panos_security_rule_group" "fail10" {
#     rule {
#         name = "my-bad-rule-fail10"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "  "
#     }
# }


# # Passes

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server
# resource "panos_security_policy" "pass1" {
#     rule {
#         name = "my-good-rule-pass1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server
# resource "panos_security_rule_group" "pass2" {
#     rule {
#         name = "my-good-rule-pass2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, test block with 2 passing rules 
# resource "panos_security_policy" "pass3" {
#     rule {
#         name = "my-good-rule-pass3-1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-good-rule-pass3-2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }

# # Security rules should should have a log_setting populated to ensure logs are sent to Panorama and/or a logging server, test block with 2 passing rules
# resource "panos_security_rule_group" "pass4" {
#     rule {
#         name = "my-good-rule-pass4-1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-good-rule-pass4-2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["any"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }

# # Logging can be enabled in either the panos_security_policy resource or the panos_security_rule_group resource.
# # Both resource types are covered by this check.
# # Using "log_end" enables logging at session end which is in Palo Alto Networks best practices

# # Fails

# # Logging is set to false, disabling logging, which is a fail
# resource "panos_security_policy" "fail1" {
#     rule {
#         name = "my-bad-rule-fail1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = false
#     }
# }

# # Logging is set to false, disabling logging, which is a fail
# resource "panos_security_rule_group" "fail2" {
#     rule {
#         name = "my-bad-rule-fail2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = false
#     }
# }

# # Logging is set to false in the second rule, disabling logging, which is a fail
# resource "panos_security_policy" "fail3" {
#     rule {
#         name = "my-bad-rule1-fail3"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
#     rule {
#         name = "my-bad-rule2-fail3"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = false
#     }
# }

# # Logging is set to false in the second rule, disabling logging, which is a fail
# resource "panos_security_rule_group" "fail4" {
#     rule {
#         name = "my-bad-rule1-fail4"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
#     rule {
#         name = "my-bad-rule2-fail4"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = false
#     }
# }

# # Passes

# # Logging is set to true, enabling logging, which is a pass
# resource "panos_security_policy" "pass1" {
#     rule {
#         name = "my-good-rule-pass1"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
# }

# # Logging is set to true, enabling logging, which is a pass
# resource "panos_security_rule_group" "pass2" {
#     rule {
#         name = "my-good-rule-pass2"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
# }

# # Not explicitly setting the log_end attribute when creating a rule leads to the default setting of true, which ensures logging is enabled, which is a pass
# resource "panos_security_policy" "pass3" {
#     rule {
#         name = "my-good-rule-pass3"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }

# # Not explicitly setting the log_end attribute when creating a rule leads to the default setting of true, which ensures logging is enabled, which is a pass
# resource "panos_security_rule_group" "pass4" {
#     rule {
#         name = "my-good-rule-pass4"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }

# # log_end is set to true in both rules, ensuring logging is enabled, which is a pass
# resource "panos_security_policy" "pass5" {
#     rule {
#         name = "my-good-rule1-pass5"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
#     rule {
#         name = "my-good-rule2-pass5"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
# }

# # log_end is set to true in both rules, ensuring logging is enabled, which is a pass
# resource "panos_security_rule_group" "pass6" {
#     rule {
#         name = "my-good-rule1-pass6"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
#     rule {
#         name = "my-good-rule2-pass6"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#         log_end = true
#     }
# }

# # Not explicitly setting the log_end attribute when creating a rule leads to the default setting of true, which ensures logging is enabled, which is a pass for both rules
# resource "panos_security_policy" "pass7" {
#     rule {
#         name = "my-good-rule1-pass7"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-good-rule2-pass7"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }

# # Not explicitly setting the log_end attribute when creating a rule leads to the default setting of true, which ensures logging is enabled, which is a pass for both rules
# resource "panos_security_rule_group" "pass8" {
#     rule {
#         name = "my-good-rule1-pass8"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
#     rule {
#         name = "my-good-rule2-pass8"
#         source_zones = ["any"]
#         source_addresses = ["10.10.10.10/32"]
#         source_users = ["any"]
#         hip_profiles = ["any"]
#         destination_zones = ["any"]
#         destination_addresses = ["8.8.8.8/32"]
#         applications = ["web-browsing","ssl"]
#         categories = ["any"]
#         services = ["application-default"]
#         action = "allow"
#         description = "This rule is for..."
#         log_setting = "my-log-fwd-profile"
#     }
# }