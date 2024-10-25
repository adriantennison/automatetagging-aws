variable "lambda_s3_bucket" {
  type        = string
  description = "S3 bucket where the Lambda code is stored"
}

variable "lambda_s3_key" {
  type        = string
  description = "S3 key for the Lambda code package"
}