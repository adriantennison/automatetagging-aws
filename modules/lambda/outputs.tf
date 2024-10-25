output "lambda_function_arn" {
  value       = aws_lambda_function.tagging_lambda.arn
  description = "The ARN of the Lambda function used for tagging."
}

output "lambda_execution_role_arn" {
  value       = aws_iam_role.lambda_execution_role.arn
  description = "The ARN of the IAM role used by the Lambda function."
}
