variable "bucket_name" {
  type = string
  description = "The name of the S3 bucket, must be globally unique"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "my_bucket_domain_name" {
  value = aws_s3_bucket.my_bucket.bucket_domain_name
}