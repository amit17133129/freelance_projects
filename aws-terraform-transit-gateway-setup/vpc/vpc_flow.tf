resource "aws_flow_log" "vpc_flow" {
  count                = 1
  log_destination      = aws_s3_bucket.s3.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = "${aws_vpc.vpc[count.index].id}"
}

resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  force_destroy = true
}