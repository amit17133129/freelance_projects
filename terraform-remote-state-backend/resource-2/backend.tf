terraform {
  backend "s3" {
    bucket = "my-bucket-xxxxxx"
    key    = "dev/subnet/main/terraform.tfstate"
    region = "us-east-1"
  }
}

#### refering the vpc (resource-1) remote backend
data "terraform_remote_state" "vpc_subnets_ids" {
  backend = "s3"

  config = {
    bucket = "my-bucket-xxxxxx"
    key    = "dev/vpc/main/terraform.tfstate"
    region = "us-east-1"
  }
}