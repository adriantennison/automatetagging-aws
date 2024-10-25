resource "aws_lambda_function" "lambda_function" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda.arn
  handler       = "lambda_function.handler"  # Update according to your Lambda's handler
  runtime       = "python3.8"

  s3_bucket = var.lambda_s3_bucket
  s3_key    = "lambda_function.zip"

  environment {
    variables = {
      TAG1KEY = "Environment",
      TAG2KEY = "Owner"
    }
  }

  depends_on = [
    aws_s3_bucket_object.lambda_zip
  ]
}

resource "null_resource" "lambda_packaging" {
  triggers = {
    version = filemd5("${path.module}/src/lambda_function.py")
  }

  provisioner "local-exec" {
    command = "${path.module}/package_lambda.sh"
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src/package/"
  output_path = "${path.module}/lambda_function.zip"

  depends_on = [null_resource.lambda_packaging]
}

resource "aws_s3_bucket_object" "lambda_zip" {
   bucket = var.lambda_s3_bucket
  key    = var.lambda_s3_key
  source = data.archive_file.lambda_zip.output_path
  etag   = filemd5(data.archive_file.lambda_zip.output_path)
}
