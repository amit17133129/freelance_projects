module "s3" {
    source = "../../modules/s3-buckets"
    env    = var.env
    s3_bucket_name = var.s3_bucket_name
}