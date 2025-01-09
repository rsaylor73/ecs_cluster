resource "aws_s3_bucket" "cicd_bucket" {
  bucket        = var.artifacts_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "control" {
  bucket = aws_s3_bucket.cicd_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [aws_s3_bucket_ownership_controls.control]

  bucket = aws_s3_bucket.cicd_bucket.id
  acl    = "private"
}
