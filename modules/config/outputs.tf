output "config_rule_id" {
  value       = aws_config_config_rule.untagged_resources.id
  description = "The ID of the AWS Config rule monitoring untagged resources."
}
