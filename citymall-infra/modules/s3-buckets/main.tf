resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
  
  tags = {
    Name        = var.s3_bucket_name
    Environment = var.env
  }
}

/* resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
} */