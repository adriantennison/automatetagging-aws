output "config_rule_id" {
  value       = module.config.config_rule_id
  description = "The ID of the AWS Config rule created to monitor for untagged resources."
}

output "lambda_function_arn" {
  value       = module.lambda.lambda_function_arn
  description = "The ARN of the Lambda function used for auto-tagging AWS resources."
}

output "lambda_execution_role_arn" {
  value       = module.lambda.lambda_execution_role_arn
  description = "The ARN of the IAM role assumed by the Lambda function."
}

output "eventbridge_rule_name" {
  value       = module.eventbridge.eventbridge_rule_name
  description = "The name of the EventBridge rule used to trigger the Lambda function."
}
