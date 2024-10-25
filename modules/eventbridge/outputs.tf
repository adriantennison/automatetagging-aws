output "eventbridge_rule_name" {
  value       = aws_cloudwatch_event_rule.config_changes.name
  description = "The name of the EventBridge rule that triggers the Lambda function."
}
