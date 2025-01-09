resource "random_id" "bucket" {
  byte_length = 5
}

module "cicd_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.artifacts_bucket_name}-${random_id.bucket.hex}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
