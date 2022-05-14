terraform {
  backend "s3" {
    bucket = "my-bucket-xxxxxx"
    key    = "dev/vpc/main/terraform.tfstate"
    region = "us-east-1"
  }
}