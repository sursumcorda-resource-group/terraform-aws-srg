resource "aws_s3_bucket" "s3" {
  bucket = var.name
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_server_side_encryption" {
  bucket = aws_s3_bucket.s3.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "s3_policy" {
  count = var.policy != null ? 1 : 0
  
  bucket = aws_s3_bucket.s3.id
  policy = var.policy
}

resource "aws_s3_bucket_logging" "s3_logging" {
  count = var.logging != null ? 1 : 0

  bucket = aws_s3_bucket.s3.id

  target_bucket = var.logging.bucket_id
  target_prefix = var.logging.bucket_prefix
}