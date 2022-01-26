resource "aws_config_conformance_pack" "example" {
  name            = "example"
  template_s3_uri = "s3://${aws_s3_bucket.example.bucket}/${aws_s3_bucket_object.example.key}"

  depends_on = [aws_config_configuration_recorder.recorder]
}

resource "aws_s3_bucket" "example" {
  bucket = "examplexxxyyyyzzzzz"
}

resource "aws_s3_bucket_object" "example" {
  bucket  = aws_s3_bucket.example.id
  key     = "example-key"
  content = <<EOT
Resources:
  IAMPasswordPolicy:
    Properties:
      ConfigRuleName: IAMPasswordPolicy
      Source:
        Owner: AWS
        SourceIdentifier: IAM_PASSWORD_POLICY
    Type: AWS::Config::ConfigRule
EOT
}
