# provider "aws" {
#   access_key = "${var.access_key}"
#   secret_key = "${var.secret_key}"
#   region     = "${var.region}"
# }

provider "aws" {
  alias = "east1"
  region = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

provider "aws" {
  alias = "west1"
  region = "us-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}