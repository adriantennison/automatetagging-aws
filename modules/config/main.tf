resource "aws_config_config_rule" "untagged_resources" {
  name = "untagged-resources"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  scope {
    compliance_resource_types = var.resource_types
  }

  input_parameters = jsonencode({
    "tag1Key": "Environment",
    "tag2Key": "Owner"
  })
}
