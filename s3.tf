resource "aws_s3_bucket" "source_bucket" {
    bucket = "${data.aws_caller_identity.current.account_id}-${var.region}-${var.bucket_pattern}"
}

resource "aws_s3_bucket_acl" "source_bucket_acl" {
    bucket = aws_s3_bucket.source_bucket.id
    acl    = "private"
    
}

resource "aws_s3_bucket_public_access_block" "source_bucket_block_public" {
    bucket                  = aws_s3_bucket.source_bucket.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}