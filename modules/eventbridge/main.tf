resource "aws_cloudwatch_event_rule" "config_changes" {
  name        = "config-rule-compliance-changes"
  description = "Trigger on config rule compliance changes."

  event_pattern = jsonencode({
    "source"      = ["aws.config"],
    "detail-type" = ["Config Rules Compliance Change"],
    "detail"      = {
      "configRuleName" = ["untagged-resources"],
      "newEvaluationResult" = {
        "complianceType" = ["NON_COMPLIANT"]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.config_changes.name
  target_id = "TargetFunction"
  arn       = var.lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tagging_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.config_changes.arn
}
