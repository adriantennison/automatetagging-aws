
resource "aws_lambda_function" "tagging_lambda" {
  function_name = "auto_tagging_function"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  environment {
    variables = {
      TAG1KEY = "Environment",
      TAG2KEY = "Owner"
    }
  }
}
