# Commit the rulestack
resource "cloudngfwaws_commit_rulestack" "the_commit" {
  rulestack = local.rulestack_name
}
