# resource "aws_flow_log" "vpc_flow" {
#   count                = 1
#   log_destination      = aws_s3_bucket.s3.arn
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   vpc_id               = "${aws_vpc.vpc[count.index].id}"
# }

resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_flow_log" "vpc_flow" {
  for_each = {
    vpc1_id = aws_vpc.vpc[0].id 
    vpc2_id = aws_vpc.vpc[1].id 
    vpc3_id = aws_vpc.vpc[2].id 
  }

  log_destination      = aws_s3_bucket.s3.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id = each.value
}

