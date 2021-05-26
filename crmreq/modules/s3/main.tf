data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    sid = var.writable ? "AllowPuts" : "PublicReadGetObject"

    actions = var.writable ? ["s3:PutObject"] : ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::${var.name}",
      "arn:aws:s3:::${var.name}/*",
    ]
  }
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 2"

  tags = {
    environment = var.env
  }

  bucket        = var.name
  acl           = "private"
  force_destroy = true
  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json

  versioning = {
    enabled = true
  }

  website = {
    index_document = "index.html"
  }

  cors_rule = [
    {
      allowed_methods = ["PUT", "POST"]
      allowed_origins = [""]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3600
    }
  ]
}
