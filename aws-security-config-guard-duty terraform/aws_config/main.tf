resource "aws_config_config_rule" "config_rule" {
  name = var.config_rule_name

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.recorder]
}

resource "aws_config_configuration_recorder" "recorder" {
  name     = var.config_configuration_recorder_name
  role_arn = aws_iam_role.role.arn
}

resource "aws_iam_role" "role" {
  name = var.iam_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "iam_policy" {
  name = var.role_policy_name
  role = aws_iam_role.role.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": "config:Put*",
          "Effect": "Allow",
          "Resource": "*"

      }
  ]
}
POLICY
}
