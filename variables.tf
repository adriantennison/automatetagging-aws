variable "resource_types" {
  type = list(string)
  description = "List of AWS resource types to monitor"
}

variable "lambda_function_arn" {
  type        = string
  description = "ARN of the Lambda function to be triggered"
}

variable "lambda_s3_bucket" {
  type        = string
  description = "S3 bucket where the Lambda code is stored"
}

variable "lambda_s3_key" {
  type        = string
  description = "S3 key for the Lambda code package"
}