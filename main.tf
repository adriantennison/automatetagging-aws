module "config" {
  source        = "./modules/config"
  resource_types = var.resource_types
}

module "lambda" {
  source          = "./modules/lambda"
  lambda_s3_bucket = var.lambda_s3_bucket
  lambda_s3_key    = var.lambda_s3_key
}

module "eventbridge" {
  source             = "./modules/eventbridge"
  lambda_function_arn = module.lambda.tagging_lambda.arn
}
